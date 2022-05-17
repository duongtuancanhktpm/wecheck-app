// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:collection' show LinkedHashMap;
import 'dart:math' show pi, Point, Rectangle;

import 'package:wecheck/flutter_chart/common/src/chart/cartesian/axis/axis_custom.dart'
    show AxisCustom;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../common/color.dart' show Color;
import '../../../common/graphics_factory.dart' show GraphicsFactory;
import '../../../common/style/style_factory.dart' show StyleFactory;
import '../../../common/text_element.dart'
    show MaxWidthStrategy, TextDirection, TextElement;

// import '../../../common/text_style.dart' show TextStyle;
// import '../../cartesian/axis/axis_custom.dart' show Axis;
import '../../cartesian/axis/spec/axis_spec.dart' show TextStyleSpec;
import '../../cartesian/cartesian_chart.dart' show CartesianChart;
import '../../layout/layout_view.dart'
    show
        LayoutPosition,
        LayoutView,
        LayoutViewConfig,
        LayoutViewPaintOrder,
        LayoutViewPositionOrder,
        ViewMeasuredSizes;
import '../base_chart.dart' show BaseChart, LifecycleListener;
import '../chart_canvas.dart' show ChartCanvas, getAnimatedColor;
import '../processed_series.dart' show MutableSeries;
import 'chart_behavior.dart' show ChartBehavior;

const _defaultStrokeWidthPx = 2.0;

/// Chart behavior that annotates domain ranges with a solid fill color.
///
/// The annotations will be drawn underneath series data and chart axes.
///
/// This is typically used for line charts to call out sections of the data
/// range.
///
/// TODO: Support labels.
class RangeAnnotationCustom<D> implements ChartBehavior<D> {
  static const _defaultLabelAnchor = AnnotationLabelAnchorCustom.end;
  static const _defaultLabelDirection = AnnotationLabelDirectionCustom.auto;
  static const _defaultLabelPosition = AnnotationLabelPositionCustom.auto;
  static const _defaultLabelPadding = 5;
  static final _defaultLabelStyle =
      TextStyleSpec(fontSize: 12, color: Color.black);

  /// List of annotations to render on the chart.
  final List<AnnotationSegmentCustom<Object>> annotations;

  /// Default color for annotations.
  final Color defaultColor;

  /// Configures where to anchor annotation label text.
  final AnnotationLabelAnchorCustom defaultLabelAnchor;

  /// Direction of label text on the annotations.
  final AnnotationLabelDirectionCustom defaultLabelDirection;

  /// Configures where to place labels relative to the annotation.
  final AnnotationLabelPositionCustom defaultLabelPosition;

  /// Configures the style of label text.
  final TextStyleSpec defaultLabelStyleSpec;

  /// Configures the stroke width for line annotations.
  final double defaultStrokeWidthPx;

  /// Whether or not the range of the axis should be extended to include the
  /// annotation start and end values.
  final bool extendAxis;

  /// Space before and after label text.
  final int labelPadding;

  /// Configures the order in which the behavior should be painted.
  /// This value should be relative to LayoutPaintViewOrder.rangeAnnotation.
  /// (e.g. LayoutViewPaintOrder.rangeAnnotation + 1)
  final int layoutPaintOrder;

  late CartesianChart<D> _chart;

  late _RangeAnnotationLayoutViewCustom<D> _view;

  late LifecycleListener<D> _lifecycleListener;

  /// Store a map of data drawn on the chart, mapped by series name.
  ///
  /// [LinkedHashMap] is used to render the series on the canvas in the same
  /// order as the data was given to the chart.
  // ignore: prefer_collection_literals, https://github.com/dart-lang/linter/issues/1649
  final _annotationMap = LinkedHashMap<String, _AnimatedAnnotationCustom<D>>();

  // Store a list of annotations that exist in the current annotation list.
  //
  // This list will be used to remove any [_AnimatedAnnotation] that were
  // rendered in previous draw cycles, but no longer have a corresponding datum
  // in the new data.
  final _currentKeys = <String>[];

  RangeAnnotationCustom(this.annotations,
      {Color? defaultColor,
      AnnotationLabelAnchorCustom? defaultLabelAnchor,
      AnnotationLabelDirectionCustom? defaultLabelDirection,
      AnnotationLabelPositionCustom? defaultLabelPosition,
      TextStyleSpec? defaultLabelStyleSpec,
      bool? extendAxis,
      int? labelPadding,
      double? defaultStrokeWidthPx,
      int? layoutPaintOrder})
      : defaultColor = StyleFactory.style.rangeAnnotationColor,
        defaultLabelAnchor = defaultLabelAnchor ?? _defaultLabelAnchor,
        defaultLabelDirection = defaultLabelDirection ?? _defaultLabelDirection,
        defaultLabelPosition = defaultLabelPosition ?? _defaultLabelPosition,
        defaultLabelStyleSpec = defaultLabelStyleSpec ?? _defaultLabelStyle,
        extendAxis = extendAxis ?? true,
        labelPadding = labelPadding ?? _defaultLabelPadding,
        defaultStrokeWidthPx = defaultStrokeWidthPx ?? _defaultStrokeWidthPx,
        layoutPaintOrder =
            layoutPaintOrder ?? LayoutViewPaintOrder.rangeAnnotation {
    _lifecycleListener = LifecycleListener<D>(
        onPostprocess: _updateAxisRange, onAxisConfigured: _updateViewData);
  }

  @override
  void attachTo(BaseChart<D> chart) {
    if (chart is! CartesianChart<D>) {
      throw ArgumentError(
          'RangeAnnotation can only be attached to a CartesianChart<D>');
    }

    _chart = chart;

    _view = _RangeAnnotationLayoutViewCustom<D>(
        defaultColor: defaultColor,
        labelPadding: labelPadding,
        chart: _chart,
        rangeAnnotation: this,
        layoutPaintOrder: layoutPaintOrder);

    chart.addView(_view);

    chart.addLifecycleListener(_lifecycleListener);
  }

  @override
  void removeFrom(BaseChart<D> chart) {
    chart.removeView(_view);
    chart.removeLifecycleListener(_lifecycleListener);

    _view.chart = null;
  }

  /// Sub-classes can override this method to control label visibility.
  @protected
  bool shouldShowLabels(AnnotationSegmentCustom<Object> annotation) => true;

  void _updateAxisRange(List<MutableSeries<D>> seriesList) {
    // Extend the axis range if enabled.
    if (extendAxis) {
      for (final annotation in annotations) {
        // Either an Axis<D> and Axis<num>.
        AxisCustom<Object?> axis;

        switch (annotation.axisType) {
          case RangeAnnotationAxisTypeCustom.domain:
            axis = _chart.domainAxis!;
            break;

          case RangeAnnotationAxisTypeCustom.measure:
            // We expect an empty axisId to get us the primary measure axis.
            axis = _chart.getMeasureAxis(axisId: annotation.axisId);
            break;
        }

        if (annotation is RangeAnnotationSegmentCustom<Object>) {
          axis.addDomainValue(annotation.startValue);
          axis.addDomainValue(annotation.endValue);
        } else if (annotation is LineAnnotationSegmentCustom<Object>) {
          axis.addDomainValue(annotation.value);
        }
      }
    }
  }

  void _updateViewData() {
    _currentKeys.clear();

    // The values (T) can match the data type of the domain (D) or measure axis
    // (num).
    void updateAnnotation<T>(
      AxisCustom<T> axis,
      AnnotationSegmentCustom<Object> annotation,
    ) {
      final key = annotation.key;

      final color = annotation.color ?? defaultColor;

      final startLabel = annotation.startLabel;
      final endLabel = annotation.endLabel;
      final middleLabel = annotation.middleLabel;
      final labelAnchor = annotation.labelAnchor ?? defaultLabelAnchor;
      var labelDirection = annotation.labelDirection ?? defaultLabelDirection;

      if (labelDirection == AnnotationLabelDirectionCustom.auto) {
        switch (annotation.axisType) {
          case RangeAnnotationAxisTypeCustom.domain:
            labelDirection = AnnotationLabelDirectionCustom.vertical;
            break;

          case RangeAnnotationAxisTypeCustom.measure:
            labelDirection = AnnotationLabelDirectionCustom.horizontal;
            break;
        }
      }

      final labelPosition = annotation.labelPosition ?? defaultLabelPosition;
      final labelStyleSpec = annotation.labelStyleSpec ?? defaultLabelStyleSpec;

      // Add line annotation settings.
      final dashPattern = annotation is LineAnnotationSegmentCustom<Object>
          ? annotation.dashPattern
          : null;
      final strokeWidthPx = annotation is LineAnnotationSegmentCustom<Object>
          ? annotation.strokeWidthPx
          : 0.0;

      final isRange = annotation is RangeAnnotationSegmentCustom;

      final T startValue;
      final T endValue;

      final bool isShowLineStart;
      final bool isShowLineEnd;
      final double lengthLineStart;
      final double lengthLineEnd;
      final Color colorLine;

      // FFFFFFSSSS

      // We unfortunately can't check for `RangeAnnotationSegment<T>` nor
      // `LineAnnotationSegment<T>` here because the `AnnotationSegment` object
      // might not have been parameterized on `T` when it was initially
      // constructed.
      if (annotation is RangeAnnotationSegmentCustom<Object>) {
        startValue = annotation.startValue as T;
        endValue = annotation.endValue as T;
        isShowLineStart = annotation.isShowLineStart;
        isShowLineEnd = annotation.isShowLineEnd;
        lengthLineStart = annotation.lengthLineStart;
        lengthLineEnd = annotation.lengthLineEnd;
        colorLine = annotation.colorLine;
      } else if (annotation is LineAnnotationSegmentCustom<Object>) {
        startValue = endValue = annotation.value as T;
        isShowLineStart = false;
        isShowLineEnd = false;
        lengthLineStart = 0;
        lengthLineEnd = 0;
        colorLine = Color.black.lighter;
      } else {
        throw UnsupportedError(
            'Unrecognized annotation type: ${annotation.runtimeType}');
      }

      final annotationDatum =
          _getAnnotationDatum(startValue, endValue, axis, annotation.axisType);

      // If we already have a animatingAnnotation for that index, use it.
      var animatingAnnotation = _annotationMap[key];
      if (animatingAnnotation == null) {
        // Create a new annotation, positioned at the start and end values.
        animatingAnnotation = _AnimatedAnnotationCustom<D>(key: key)
          ..setNewTarget(_AnnotationElementCustom<D>(
            annotation: annotationDatum,
            annotationSegment: annotation,
            color: color,
            dashPattern: dashPattern,
            startLabel: startLabel,
            endLabel: endLabel,
            isShowLineStart: isShowLineStart,
            isShowLineEnd: isShowLineEnd,
            lengthLineStart: lengthLineStart,
            lengthLineEnd: lengthLineEnd,
            colorLine: colorLine,
            middleLabel: middleLabel,
            isRange: isRange,
            labelAnchor: labelAnchor,
            labelDirection: labelDirection,
            labelPosition: labelPosition,
            labelStyleSpec: labelStyleSpec,
            strokeWidthPx: strokeWidthPx,
          ));

        _annotationMap[key] = animatingAnnotation;
      }

      // Update the set of annotations that still exist in the series data.
      _currentKeys.add(key);

      // Get the annotation element we are going to setup.
      final annotationElement = _AnnotationElementCustom<D>(
        annotation: annotationDatum,
        annotationSegment: annotation,
        color: color,
        dashPattern: dashPattern,
        startLabel: startLabel,
        endLabel: endLabel,
        middleLabel: middleLabel,
        isShowLineStart: isShowLineStart,
        isShowLineEnd: isShowLineEnd,
        lengthLineStart: lengthLineStart,
        lengthLineEnd: lengthLineEnd,
        colorLine: colorLine,
        isRange: isRange,
        labelAnchor: labelAnchor,
        labelDirection: labelDirection,
        labelPosition: labelPosition,
        labelStyleSpec: labelStyleSpec,
        strokeWidthPx: strokeWidthPx,
      );

      animatingAnnotation.setNewTarget(annotationElement);
    }

    for (final annotation in annotations) {
      switch (annotation.axisType) {
        case RangeAnnotationAxisTypeCustom.domain:
          updateAnnotation(_chart.domainAxis!, annotation);
          break;

        case RangeAnnotationAxisTypeCustom.measure:
          // We expect an empty axisId to get us the primary measure axis.
          updateAnnotation(
              _chart.getMeasureAxis(axisId: annotation.axisId), annotation);
          break;
      }
    }

    // Animate out annotations that don't exist anymore.
    _annotationMap
        .forEach((String key, _AnimatedAnnotationCustom<D> annotation) {
      if (!_currentKeys.contains(annotation.key)) {
        annotation.animateOut();
      }
    });

    _view.annotationMap = _annotationMap;
  }

  /// Generates a datum that describes an annotation.
  ///
  /// [startValue] and [endValue] are dynamic because they can be different data
  /// types for domain and measure axes, e.g. DateTime and num for a TimeSeries
  /// chart.
  _DatumAnnotationCustom _getAnnotationDatum<T>(T startValue, T endValue,
      AxisCustom<T> axis, RangeAnnotationAxisTypeCustom axisType) {
    // Remove floating point rounding errors by rounding to 2 decimal places of
    // precision. The difference in the canvas is negligible.
    final startPosition = (axis.getLocation(startValue)! * 100).round() / 100;
    final endPosition = (axis.getLocation(endValue)! * 100).round() / 100;

    return _DatumAnnotationCustom(
        startPosition: startPosition,
        endPosition: endPosition,
        axisType: axisType);
  }

  @override
  String get role => 'RangeAnnotation';
}

class _RangeAnnotationLayoutViewCustom<D> extends LayoutView {
  @override
  final LayoutViewConfig layoutConfig;

  final Color defaultColor;

  final int labelPadding;

  final RangeAnnotationCustom<D> rangeAnnotation;

  final int layoutPaintOrder;

  CartesianChart<D>? chart;

  bool get isRtl => chart!.context.isRtl;

  late Rectangle<int> _drawAreaBounds;

  Rectangle<int> get drawBounds => _drawAreaBounds;

  @override
  GraphicsFactory? graphicsFactory;

  /// Store a map of series drawn on the chart, mapped by series name.
  ///
  /// [LinkedHashMap] is used to render the series on the canvas in the same
  /// order as the data was given to the chart.
  LinkedHashMap<String, _AnimatedAnnotationCustom<D>>? _annotationMap;

  _RangeAnnotationLayoutViewCustom(
      {required this.defaultColor,
      required this.labelPadding,
      required this.chart,
      required this.rangeAnnotation,
      required this.layoutPaintOrder})
      : layoutConfig = LayoutViewConfig(
            paintOrder: layoutPaintOrder,
            position: LayoutPosition.DrawArea,
            positionOrder: LayoutViewPositionOrder.drawArea);

  set annotationMap(LinkedHashMap<String, _AnimatedAnnotationCustom<D>> value) {
    _annotationMap = value;
  }

  @override
  ViewMeasuredSizes? measure(int maxWidth, int maxHeight) {
    return null;
  }

  @override
  void layout(Rectangle<int> componentBounds, Rectangle<int> drawAreaBounds) {
    _drawAreaBounds = drawAreaBounds;
  }

  @override
  void paint(ChartCanvas canvas, double animationPercent) {
    final _annotationMap = this._annotationMap;
    if (_annotationMap == null) {
      return;
    }

    // Clean up the annotations that no longer exist.
    if (animationPercent == 1.0) {
      final keysToRemove = <String>[];

      _annotationMap
          .forEach((String key, _AnimatedAnnotationCustom<D> annotation) {
        if (annotation.animatingOut) {
          keysToRemove.add(key);
        }
      });

      keysToRemove.forEach(_annotationMap.remove);
    }

    _annotationMap
        .forEach((String key, _AnimatedAnnotationCustom<D> annotation) {
      final annotationElement =
          annotation.getCurrentAnnotation(animationPercent);

      // Calculate the bounds of a range annotation.
      //
      // This will still be used for line annotations to compute the position of
      // labels. We always expect those to end up outside, since the bounds will
      // have zero width or  height.
      final bounds = _getAnnotationBounds(annotationElement);

      if (annotationElement.isRange) {
        // Draw the annotation.
        canvas.drawRect(bounds, fill: annotationElement.color);
      } else {
        // Calculate the points for a line annotation.
        final points = _getLineAnnotationPoints(annotationElement);

        // Draw the annotation.
        canvas.drawLine(
            dashPattern: annotationElement.dashPattern,
            points: points,
            stroke: annotationElement.color,
            strokeWidthPx: annotationElement.strokeWidthPx);
      }

      // Create [TextStyle] from [TextStyleSpec] to be used by all the elements.
      // The [GraphicsFactory] is needed so it can't be created earlier.
      // final labelStyle =
      //     _getTextStyle(graphicsFactory!, annotationElement.labelStyleSpec);

      final rotation = annotationElement.labelDirection ==
              AnnotationLabelDirectionCustom.vertical
          ? -pi / 2
          : 0.0;

      if (rangeAnnotation
          .shouldShowLabels(annotationElement.annotationSegment)) {
        final labels = {
          if (annotationElement.startLabel != null)
            _AnnotationLabelTypeCustom.start: annotationElement.startLabel,
          // _AnnotationLabelTypeCustom.start: Icon(Icons.phone),
          if (annotationElement.endLabel != null)
            _AnnotationLabelTypeCustom.end: annotationElement.endLabel,
          if (annotationElement.middleLabel != null)
            _AnnotationLabelTypeCustom.middle: annotationElement.middleLabel,
        };

        // Draw labels that have been defined.
        labels.forEach((labelType, label) {
          // DDDEEE
          String name = labelType.name;
          if(name=='start') {
            name= 'M1';
          } else if (name == 'end') {
            name = 'M2';
          } else if (name == 'middle') {
            name = 'M2';
          }
          final labelElement = graphicsFactory!.createTextElement(name)
            ..maxWidthStrategy = MaxWidthStrategy.ellipsize;

          // Measure the label max width once if either type of label is defined.
          labelElement.maxWidth =
              _getLabelMaxWidth(bounds, annotationElement, labelElement);

          final labelPoint = _getLabelPosition(
              labelType, bounds, annotationElement, labelElement);

          if (labelPoint != null) {
            canvas.drawText(labelElement, labelPoint.x, labelPoint.y,
                rotation: rotation);
            IconData? icon;
            if (labelType == _AnnotationLabelTypeCustom.start) {
              icon = annotationElement.startLabel;
            } else if (labelType == _AnnotationLabelTypeCustom.end) {
              icon = annotationElement.endLabel;
            } else if (labelType == _AnnotationLabelTypeCustom.middle) {
              icon = annotationElement.middleLabel;
            }

            if (icon != null) {
              canvas.drawIconText(
                  labelElement,
                  icon,
                  annotationElement.isShowLineStart,
                  annotationElement.isShowLineEnd,
                  annotationElement.lengthLineStart,
                  annotationElement.lengthLineEnd,
                  annotationElement.colorLine,
                  labelPoint.x,
                  labelPoint.y,
                  rotation: rotation);
            }
          }
        });
      }
    });
  }

  /// Calculates the bounds of the annotation.
  Rectangle<num> _getAnnotationBounds(
      _AnnotationElementCustom<D> annotationElement) {
    Rectangle<num> bounds;

    switch (annotationElement.annotation.axisType) {
      case RangeAnnotationAxisTypeCustom.domain:
        bounds = Rectangle<num>(
            annotationElement.annotation.startPosition,
            _drawAreaBounds.top,
            annotationElement.annotation.endPosition -
                annotationElement.annotation.startPosition,
            _drawAreaBounds.height);
        break;

      case RangeAnnotationAxisTypeCustom.measure:
        bounds = Rectangle<num>(
            _drawAreaBounds.left,
            annotationElement.annotation.endPosition,
            _drawAreaBounds.width,
            annotationElement.annotation.startPosition -
                annotationElement.annotation.endPosition);
        break;
    }

    return bounds;
  }

  /// Calculates the bounds of the annotation.
  List<Point> _getLineAnnotationPoints(
      _AnnotationElementCustom<D> annotationElement) {
    final points = <Point>[];

    switch (annotationElement.annotation.axisType) {
      case RangeAnnotationAxisTypeCustom.domain:
        points.add(Point<num>(
            annotationElement.annotation.startPosition, _drawAreaBounds.top));
        points.add(Point<num>(
            annotationElement.annotation.endPosition, _drawAreaBounds.bottom));
        break;

      case RangeAnnotationAxisTypeCustom.measure:
        points.add(Point<num>(
            _drawAreaBounds.left, annotationElement.annotation.startPosition));
        points.add(Point<num>(
            _drawAreaBounds.right, annotationElement.annotation.endPosition));
        break;
    }

    return points;
  }

  /// Measures the max label width of the annotation.
  int _getLabelMaxWidth(Rectangle<num> bounds,
      _AnnotationElementCustom<D> annotationElement, TextElement labelElement) {
    num maxWidth = 0;

    final calculatedLabelPosition =
        _resolveAutoLabelPosition(bounds, annotationElement, labelElement);

    if (annotationElement.labelPosition ==
            AnnotationLabelPositionCustom.margin &&
        annotationElement.annotation.axisType ==
            RangeAnnotationAxisTypeCustom.measure) {
      switch (annotationElement.annotation.axisType) {
        case RangeAnnotationAxisTypeCustom.domain:
          break;

        case RangeAnnotationAxisTypeCustom.measure:
          switch (annotationElement.labelAnchor) {
            case AnnotationLabelAnchorCustom.start:
              maxWidth = chart!.marginLeft - labelPadding;
              break;

            case AnnotationLabelAnchorCustom.end:
              maxWidth = chart!.marginRight - labelPadding;
              break;

            case AnnotationLabelAnchorCustom.middle:
              break;
          }
          break;
      }
    } else {
      if (calculatedLabelPosition == AnnotationLabelPositionCustom.outside) {
        maxWidth = annotationElement.labelDirection ==
                AnnotationLabelDirectionCustom.horizontal
            ? drawBounds.width
            : drawBounds.height;
      } else {
        maxWidth = annotationElement.labelDirection ==
                AnnotationLabelDirectionCustom.horizontal
            ? bounds.width
            : bounds.height;
      }
    }

    return maxWidth.round();
  }

  /// Gets the resolved location for a label element.
  Point<int>? _getLabelPosition(
      _AnnotationLabelTypeCustom labelType,
      Rectangle<num> bounds,
      _AnnotationElementCustom<D> annotationElement,
      TextElement labelElement) {
    switch (annotationElement.annotation.axisType) {
      case RangeAnnotationAxisTypeCustom.domain:
        return _getDomainLabelPosition(
            labelType, bounds, annotationElement, labelElement);

      case RangeAnnotationAxisTypeCustom.measure:
        return _getMeasureLabelPosition(
            labelType, bounds, annotationElement, labelElement);
    }
  }

  /// Gets the resolved location for a domain annotation label element.
  Point<int> _getDomainLabelPosition(
      _AnnotationLabelTypeCustom labelType,
      Rectangle<num> bounds,
      _AnnotationElementCustom<D> annotationElement,
      TextElement labelElement) {
    if (annotationElement.labelDirection ==
        AnnotationLabelDirectionCustom.vertical) {
      return _getDomainLabelPositionVertical(
          labelType, bounds, annotationElement, labelElement);
    } else {
      return _getDomainLabelPositionHorizontal(
          labelType, bounds, annotationElement, labelElement);
    }
  }

  /// Gets the resolved location for a horizontal domain annotation label
  /// element.
  Point<int> _getDomainLabelPositionHorizontal(
      _AnnotationLabelTypeCustom labelType,
      Rectangle<num> bounds,
      _AnnotationElementCustom<D> annotationElement,
      TextElement labelElement) {
    num labelX = 0;
    num labelY = 0;

    final calculatedLabelPosition =
        _resolveAutoLabelPosition(bounds, annotationElement, labelElement);

    switch (annotationElement.labelAnchor) {
      case AnnotationLabelAnchorCustom.middle:
        labelY = bounds.top +
            bounds.height / 2 -
            labelElement.measurement.verticalSliceWidth / 2 -
            labelPadding;
        break;

      case AnnotationLabelAnchorCustom.end:
        if (annotationElement.labelPosition ==
            AnnotationLabelPositionCustom.margin) {
          labelY = bounds.top -
              labelElement.measurement.verticalSliceWidth -
              labelPadding;
        } else {
          labelY = bounds.top + labelPadding;
        }
        break;

      case AnnotationLabelAnchorCustom.start:
        if (annotationElement.labelPosition ==
            AnnotationLabelPositionCustom.margin) {
          labelY = bounds.bottom + labelPadding;
        } else {
          labelY = bounds.bottom -
              labelElement.measurement.verticalSliceWidth -
              labelPadding;
        }
        break;
    }

    switch (calculatedLabelPosition) {
      case AnnotationLabelPositionCustom.margin:
      case AnnotationLabelPositionCustom.auto:
        throw ArgumentError(_unresolvedAutoMessage);

      case AnnotationLabelPositionCustom.outside:
        switch (labelType) {
          case _AnnotationLabelTypeCustom.start:
            labelX = bounds.left -
                labelElement.measurement.horizontalSliceWidth -
                labelPadding;
            break;
          case _AnnotationLabelTypeCustom.end:
            labelX = bounds.right + labelPadding;
            // labelX = bounds.right  -
            //     labelElement.measurement.horizontalSliceWidth -
            //     labelPadding;
            // quannh edit sửa để hiển thị đúng icon ở chính giữa
            break;
          case _AnnotationLabelTypeCustom.middle:
            labelX = bounds.left + (bounds.width - labelElement.measurement.horizontalSliceWidth) / 2;
            break;
        }

        labelElement.textDirection =
            isRtl ? TextDirection.rtl : TextDirection.ltr;
        break;

      case AnnotationLabelPositionCustom.inside:
        switch (labelType) {
          case _AnnotationLabelTypeCustom.start:
            labelX = bounds.left - labelPadding;
            // labelX = bounds.left -
            //     labelElement.measurement.horizontalSliceWidth -
            //     labelPadding;
            break;
          case _AnnotationLabelTypeCustom.end:
            labelX = bounds.right -
                labelElement.measurement.horizontalSliceWidth +
                3 * labelPadding;
            // quannh sửa thành *3 để padding thêm
            break;
          case _AnnotationLabelTypeCustom.middle:
            labelX = bounds.left +
                (bounds.width - labelElement.measurement.horizontalSliceWidth) /
                    2;
            break;
        }

        labelElement.textDirection =
            isRtl ? TextDirection.rtl : TextDirection.ltr;
        break;
    }

    return Point<int>(labelX.round(), labelY.round());
  }

  /// Gets the resolved location for a vertical domain annotation label element.
  Point<int> _getDomainLabelPositionVertical(
      _AnnotationLabelTypeCustom labelType,
      Rectangle<num> bounds,
      _AnnotationElementCustom<D> annotationElement,
      TextElement labelElement) {
    num labelX = 0;
    num labelY = 0;

    final calculatedLabelPosition =
        _resolveAutoLabelPosition(bounds, annotationElement, labelElement);

    switch (annotationElement.labelAnchor) {
      case AnnotationLabelAnchorCustom.middle:
        labelY = bounds.top +
            bounds.height / 2 +
            labelElement.measurement.horizontalSliceWidth / 2 +
            labelPadding;
        break;

      case AnnotationLabelAnchorCustom.end:
        if (annotationElement.labelPosition ==
            AnnotationLabelPositionCustom.margin) {
          labelY = bounds.top +
              labelElement.measurement.horizontalSliceWidth +
              labelPadding;
        } else {
          labelY = bounds.top +
              labelElement.measurement.horizontalSliceWidth +
              labelPadding;
        }
        break;

      case AnnotationLabelAnchorCustom.start:
        if (annotationElement.labelPosition ==
            AnnotationLabelPositionCustom.margin) {
          labelY = bounds.bottom + labelPadding;
        } else {
          labelY = bounds.bottom -
              labelElement.measurement.horizontalSliceWidth -
              labelPadding;
        }
        break;
    }

    switch (calculatedLabelPosition) {
      case AnnotationLabelPositionCustom.margin:
      case AnnotationLabelPositionCustom.auto:
        throw ArgumentError(_unresolvedAutoMessage);

      case AnnotationLabelPositionCustom.outside:
        switch (labelType) {
          case _AnnotationLabelTypeCustom.start:
            labelX = bounds.left -
                labelElement.measurement.verticalSliceWidth -
                labelPadding;
            break;
          case _AnnotationLabelTypeCustom.end:
            labelX = bounds.right + labelPadding;
            break;
          case _AnnotationLabelTypeCustom.middle:
            labelX = bounds.left +
                (bounds.width - labelElement.measurement.verticalSliceWidth) /
                    2;
            break;
        }

        labelElement.textDirection =
            isRtl ? TextDirection.rtl : TextDirection.ltr;
        break;

      case AnnotationLabelPositionCustom.inside:
        switch (labelType) {
          case _AnnotationLabelTypeCustom.start:
            labelX = bounds.left + labelPadding;
            break;
          case _AnnotationLabelTypeCustom.end:
            labelX = bounds.right -
                labelElement.measurement.verticalSliceWidth -
                labelPadding;
            break;
          case _AnnotationLabelTypeCustom.middle:
            labelX = bounds.left +
                (bounds.width - labelElement.measurement.verticalSliceWidth) /
                    2;
            break;
        }

        labelElement.textDirection =
            isRtl ? TextDirection.rtl : TextDirection.ltr;
        break;
    }

    return Point<int>(labelX.round(), labelY.round());
  }

  /// Gets the resolved location for a measure annotation label element.
  Point<int> _getMeasureLabelPosition(
      _AnnotationLabelTypeCustom labelType,
      Rectangle<num> bounds,
      _AnnotationElementCustom<D> annotationElement,
      TextElement labelElement) {
    if (annotationElement.labelDirection ==
        AnnotationLabelDirectionCustom.vertical) {
      return _getMeasureLabelPositionVertical(
          labelType, bounds, annotationElement, labelElement);
    } else {
      return _getMeasureLabelPositionHorizontal(
          labelType, bounds, annotationElement, labelElement);
    }
  }

  /// Gets the resolved location for a horizontal measure annotation label
  /// element.
  Point<int> _getMeasureLabelPositionHorizontal(
      _AnnotationLabelTypeCustom labelType,
      Rectangle<num> bounds,
      _AnnotationElementCustom<D> annotationElement,
      TextElement labelElement) {
    num labelX = 0;
    num labelY = 0;

    final calculatedLabelPosition =
        _resolveAutoLabelPosition(bounds, annotationElement, labelElement);

    switch (annotationElement.labelAnchor) {
      case AnnotationLabelAnchorCustom.middle:
        labelX = bounds.left +
            bounds.width / 2 -
            labelElement.measurement.horizontalSliceWidth / 2;
        labelElement.textDirection =
            isRtl ? TextDirection.rtl : TextDirection.ltr;
        break;

      case AnnotationLabelAnchorCustom.end:
      case AnnotationLabelAnchorCustom.start:
        if (annotationElement.labelPosition ==
            AnnotationLabelPositionCustom.margin) {
          final alignLeft = isRtl
              ? (annotationElement.labelAnchor ==
                  AnnotationLabelAnchorCustom.end)
              : (annotationElement.labelAnchor ==
                  AnnotationLabelAnchorCustom.start);

          if (alignLeft) {
            labelX = bounds.left - labelPadding;
            labelElement.textDirection = TextDirection.rtl;
          } else {
            labelX = bounds.right + labelPadding;
            labelElement.textDirection = TextDirection.ltr;
          }
        } else {
          final alignLeft = isRtl
              ? (annotationElement.labelAnchor ==
                  AnnotationLabelAnchorCustom.end)
              : (annotationElement.labelAnchor ==
                  AnnotationLabelAnchorCustom.start);

          if (alignLeft) {
            labelX = bounds.left + labelPadding;
            labelElement.textDirection = TextDirection.ltr;
          } else {
            labelX = bounds.right - labelPadding;
            labelElement.textDirection = TextDirection.rtl;
          }
        }
        break;
    }

    switch (calculatedLabelPosition) {
      case AnnotationLabelPositionCustom.margin:
      case AnnotationLabelPositionCustom.auto:
        throw ArgumentError(_unresolvedAutoMessage);

      case AnnotationLabelPositionCustom.outside:
        switch (labelType) {
          case _AnnotationLabelTypeCustom.start:
            labelY = bounds.bottom + labelPadding;
            break;
          case _AnnotationLabelTypeCustom.end:
            labelY = bounds.top -
                labelElement.measurement.verticalSliceWidth -
                labelPadding;
            break;
          case _AnnotationLabelTypeCustom.middle:
            labelY = bounds.top +
                (bounds.height - labelElement.measurement.verticalSliceWidth) /
                    2;
            break;
        }
        break;

      case AnnotationLabelPositionCustom.inside:
        switch (labelType) {
          case _AnnotationLabelTypeCustom.start:
            labelY = bounds.bottom -
                labelElement.measurement.verticalSliceWidth -
                labelPadding;
            break;
          case _AnnotationLabelTypeCustom.end:
            labelY = bounds.top + labelPadding;
            break;
          case _AnnotationLabelTypeCustom.middle:
            labelY = bounds.top +
                (bounds.height - labelElement.measurement.verticalSliceWidth) /
                    2;
            break;
        }
        break;
    }

    return Point<int>(labelX.round(), labelY.round());
  }

  /// Gets the resolved location for a vertical measure annotation label
  /// element.
  Point<int> _getMeasureLabelPositionVertical(
      _AnnotationLabelTypeCustom labelType,
      Rectangle<num> bounds,
      _AnnotationElementCustom<D> annotationElement,
      TextElement labelElement) {
    num labelX = 0;
    num labelY = 0;

    final calculatedLabelPosition =
        _resolveAutoLabelPosition(bounds, annotationElement, labelElement);

    switch (annotationElement.labelAnchor) {
      case AnnotationLabelAnchorCustom.middle:
        labelX = bounds.left +
            bounds.width / 2 -
            labelElement.measurement.verticalSliceWidth / 2;
        labelElement.textDirection =
            isRtl ? TextDirection.rtl : TextDirection.ltr;
        break;

      case AnnotationLabelAnchorCustom.end:
      case AnnotationLabelAnchorCustom.start:
        if (annotationElement.labelPosition ==
            AnnotationLabelPositionCustom.margin) {
          final alignLeft = isRtl
              ? (annotationElement.labelAnchor ==
                  AnnotationLabelAnchorCustom.end)
              : (annotationElement.labelAnchor ==
                  AnnotationLabelAnchorCustom.start);

          if (alignLeft) {
            labelX = bounds.left -
                labelElement.measurement.verticalSliceWidth -
                labelPadding;
            labelElement.textDirection = TextDirection.ltr;
          } else {
            labelX = bounds.right + labelPadding;
            labelElement.textDirection = TextDirection.ltr;
          }
        } else {
          final alignLeft = isRtl
              ? (annotationElement.labelAnchor ==
                  AnnotationLabelAnchorCustom.end)
              : (annotationElement.labelAnchor ==
                  AnnotationLabelAnchorCustom.start);

          if (alignLeft) {
            labelX = bounds.left + labelPadding;
            labelElement.textDirection = TextDirection.ltr;
          } else {
            labelX = bounds.right -
                labelElement.measurement.verticalSliceWidth -
                labelPadding;
            labelElement.textDirection = TextDirection.ltr;
          }
        }
        break;
    }

    switch (calculatedLabelPosition) {
      case AnnotationLabelPositionCustom.margin:
      case AnnotationLabelPositionCustom.auto:
        throw ArgumentError(_unresolvedAutoMessage);

      case AnnotationLabelPositionCustom.outside:
        switch (labelType) {
          case _AnnotationLabelTypeCustom.start:
            labelY = bounds.bottom +
                labelElement.measurement.horizontalSliceWidth +
                labelPadding;
            break;
          case _AnnotationLabelTypeCustom.end:
            labelY = bounds.top - labelPadding;
            break;
          case _AnnotationLabelTypeCustom.middle:
            labelY = bounds.bottom +
                (labelElement.measurement.horizontalSliceWidth -
                        bounds.height) /
                    2;
            break;
        }
        break;

      case AnnotationLabelPositionCustom.inside:
        switch (labelType) {
          case _AnnotationLabelTypeCustom.start:
            labelY = bounds.bottom - labelPadding;
            break;
          case _AnnotationLabelTypeCustom.end:
            labelY = bounds.top +
                labelElement.measurement.horizontalSliceWidth +
                labelPadding;
            break;
          case _AnnotationLabelTypeCustom.middle:
            labelY = bounds.bottom +
                (labelElement.measurement.horizontalSliceWidth -
                        bounds.height) /
                    2;
            break;
        }
        break;
    }

    return Point<int>(labelX.round(), labelY.round());
  }

  /// Resolves [AnnotationLabelPositionCustom.auto] configuration for an annotation
  /// into an inside or outside position, depending on the size of the
  /// annotation and the chart draw area.
  AnnotationLabelPositionCustom _resolveAutoLabelPosition(Rectangle<num> bounds,
      _AnnotationElementCustom<D> annotationElement, TextElement labelElement) {
    var calculatedLabelPosition = annotationElement.labelPosition;
    if (calculatedLabelPosition == AnnotationLabelPositionCustom.auto ||
        calculatedLabelPosition == AnnotationLabelPositionCustom.margin) {
      final isDomain = annotationElement.annotation.axisType ==
          RangeAnnotationAxisTypeCustom.domain;

      final annotationBoundsSize = isDomain ? bounds.width : bounds.height;

      final drawBoundsSize = isDomain ? drawBounds.width : drawBounds.height;

      final isVertical = annotationElement.labelDirection ==
          AnnotationLabelDirectionCustom.vertical;

      final labelSize = isDomain && isVertical || !isDomain && !isVertical
          ? labelElement.measurement.verticalSliceWidth
          : labelElement.measurement.horizontalSliceWidth;

      // Get space available inside and outside the annotation.
      final totalPadding = labelPadding * 2;
      final insideBarWidth = annotationBoundsSize - totalPadding;
      final outsideBarWidth =
          drawBoundsSize - annotationBoundsSize - totalPadding;

      // A label fits if the space inside the annotation is >= outside
      // annotation or if the length of the text fits and the space. This is
      // because if the annotation has more space than the outside, it makes
      // more sense to place the label inside the annotation, even if the
      // entire label does not fit.
      calculatedLabelPosition =
          (insideBarWidth >= outsideBarWidth || labelSize < insideBarWidth)
              ? AnnotationLabelPositionCustom.inside
              : AnnotationLabelPositionCustom.outside;
    }

    return calculatedLabelPosition;
  }

  @override
  Rectangle<int> get componentBounds => _drawAreaBounds;

  @override
  bool get isSeriesRenderer => false;

// Helper function that converts [TextStyleSpec] to [TextStyle].
// TextStyle _getTextStyle(
//     GraphicsFactory graphicsFactory, TextStyleSpec labelSpec) {
//   return graphicsFactory.createTextPaint()
//     ..color = labelSpec.color ?? Color.black
//     ..fontFamily = labelSpec.fontFamily
//     ..fontSize = labelSpec.fontSize ?? 12
//     ..lineHeight = labelSpec.lineHeight;
// }
}

class _DatumAnnotationCustom {
  final double startPosition;
  final double endPosition;
  final RangeAnnotationAxisTypeCustom axisType;

  _DatumAnnotationCustom({
    required this.startPosition,
    required this.endPosition,
    required this.axisType,
  });

  factory _DatumAnnotationCustom.from(_DatumAnnotationCustom other,
      [double? startPosition, double? endPosition]) {
    return _DatumAnnotationCustom(
        startPosition: startPosition ?? other.startPosition,
        endPosition: endPosition ?? other.endPosition,
        axisType: other.axisType);
  }
}

class _AnnotationElementCustom<D> {
  _DatumAnnotationCustom annotation;
  final AnnotationSegmentCustom<Object> annotationSegment;
  Color? color;
  final IconData? startLabel;
  final IconData? endLabel;

  final bool isShowLineStart;
  final bool isShowLineEnd;
  final double lengthLineStart;
  final double lengthLineEnd;
  final Color colorLine;

  final IconData? middleLabel;
  final bool isRange;
  final AnnotationLabelAnchorCustom labelAnchor;
  final AnnotationLabelDirectionCustom labelDirection;
  final AnnotationLabelPositionCustom labelPosition;
  final TextStyleSpec labelStyleSpec;
  final List<int>? dashPattern;
  double strokeWidthPx;

  _AnnotationElementCustom({
    required this.annotation,
    required this.annotationSegment,
    required this.color,
    required this.startLabel,
    required this.endLabel,
    required this.isShowLineStart,
    required this.isShowLineEnd,
    required this.lengthLineStart,
    required this.lengthLineEnd,
    required this.colorLine,
    required this.middleLabel,
    required this.isRange,
    required this.labelAnchor,
    required this.labelDirection,
    required this.labelPosition,
    required this.labelStyleSpec,
    required this.dashPattern,
    required this.strokeWidthPx,
  });

  _AnnotationElementCustom<D> clone() {
    return _AnnotationElementCustom<D>(
      annotation: _DatumAnnotationCustom.from(annotation),
      annotationSegment: annotationSegment,
      color: color != null ? Color.fromOther(color: color!) : null,
      startLabel: startLabel,
      endLabel: endLabel,
      isShowLineStart: isShowLineStart,
      isShowLineEnd: isShowLineEnd,
      lengthLineStart: lengthLineStart,
      lengthLineEnd: lengthLineEnd,
      colorLine: colorLine,
      middleLabel: middleLabel,
      isRange: isRange,
      labelAnchor: labelAnchor,
      labelDirection: labelDirection,
      labelPosition: labelPosition,
      labelStyleSpec: labelStyleSpec,
      dashPattern: dashPattern,
      strokeWidthPx: strokeWidthPx,
    );
  }

  void updateAnimationPercent(
    _AnnotationElementCustom<D> previous,
    _AnnotationElementCustom<D> target,
    double animationPercent,
  ) {
    final targetAnnotation = target.annotation;
    final previousAnnotation = previous.annotation;

    final startPosition =
        ((targetAnnotation.startPosition - previousAnnotation.startPosition) *
                animationPercent) +
            previousAnnotation.startPosition;

    final endPosition =
        ((targetAnnotation.endPosition - previousAnnotation.endPosition) *
                animationPercent) +
            previousAnnotation.endPosition;

    annotation = _DatumAnnotationCustom.from(
        targetAnnotation, startPosition, endPosition);

    color = getAnimatedColor(previous.color!, target.color!, animationPercent);

    strokeWidthPx =
        ((target.strokeWidthPx - previous.strokeWidthPx) * animationPercent) +
            previous.strokeWidthPx;
  }
}

enum _AnnotationLabelTypeCustom {
  start,
  end,
  middle,
}

class _AnimatedAnnotationCustom<D> {
  final String key;

  _AnnotationElementCustom<D>? _previousAnnotation;
  late _AnnotationElementCustom<D> _targetAnnotation;
  _AnnotationElementCustom<D>? _currentAnnotation;

  // Flag indicating whether this annotation is being animated out of the chart.
  bool animatingOut = false;

  _AnimatedAnnotationCustom({required this.key});

  /// Animates an annotation that was removed from the list out of the view.
  ///
  /// This should be called in place of "setNewTarget" for annotations have been
  /// removed from the list.
  /// TODO: Needed?
  void animateOut() {
    final newTarget = _currentAnnotation!.clone();

    setNewTarget(newTarget);
    animatingOut = true;
  }

  void setNewTarget(_AnnotationElementCustom<D> newTarget) {
    animatingOut = false;
    _currentAnnotation ??= newTarget.clone();
    _previousAnnotation = _currentAnnotation!.clone();
    _targetAnnotation = newTarget;
  }

  _AnnotationElementCustom<D> getCurrentAnnotation(double animationPercent) {
    if (animationPercent == 1.0 || _previousAnnotation == null) {
      _currentAnnotation = _targetAnnotation;
      _previousAnnotation = _targetAnnotation;
      return _currentAnnotation!;
    }

    _currentAnnotation!.updateAnimationPercent(
        _previousAnnotation!, _targetAnnotation, animationPercent);

    return _currentAnnotation!;
  }
}

/// Helper class that exposes fewer private internal properties for unit tests.
@visibleForTesting
class RangeAnnotationTester<D> {
  final RangeAnnotationCustom<D> behavior;

  RangeAnnotationTester(this.behavior);

  set graphicsFactory(GraphicsFactory value) {
    behavior._view.graphicsFactory = value;
  }

  void mockLayout(Rectangle<int> bounds) {
    behavior._view.layout(bounds, bounds);
  }

  /// Checks if an annotation exists with the given position and color.
  bool doesAnnotationExist(
      {num? startPosition,
      num? endPosition,
      Color? color,
      List<int>? dashPattern,
      String? startLabel,
      String? endLabel,
      String? middleLabel,
      AnnotationLabelAnchorCustom? labelAnchor,
      AnnotationLabelDirectionCustom? labelDirection,
      AnnotationLabelPositionCustom? labelPosition}) {
    for (final a in behavior._annotationMap.values) {
      final currentAnnotation = a._currentAnnotation!;
      final annotation = currentAnnotation.annotation;

      if (annotation.startPosition == startPosition &&
          annotation.endPosition == endPosition &&
          currentAnnotation.color == color &&
          currentAnnotation.startLabel == startLabel &&
          currentAnnotation.endLabel == endLabel &&
          currentAnnotation.middleLabel == middleLabel &&
          currentAnnotation.labelAnchor == labelAnchor &&
          currentAnnotation.labelDirection == labelDirection &&
          currentAnnotation.labelPosition == labelPosition &&
          (currentAnnotation is! LineAnnotationSegmentCustom ||
              currentAnnotation.dashPattern == dashPattern)) {
        return true;
      }
    }

    return false;
  }
}

/// Base class for chart annotations.
abstract class AnnotationSegmentCustom<D> {
  final RangeAnnotationAxisTypeCustom axisType;
  final String? axisId;
  final Color? color;
  final IconData? startLabel;
  final IconData? endLabel;
  final IconData? middleLabel;
  final AnnotationLabelAnchorCustom? labelAnchor;
  final AnnotationLabelDirectionCustom? labelDirection;
  final AnnotationLabelPositionCustom? labelPosition;
  final TextStyleSpec? labelStyleSpec;

  String get key;

  AnnotationSegmentCustom(this.axisType,
      {this.axisId,
      this.color,
      this.startLabel,
      this.endLabel,
      this.middleLabel,
      this.labelAnchor,
      this.labelDirection,
      this.labelPosition,
      this.labelStyleSpec});
}

/// Data for a chart range annotation.
class RangeAnnotationSegmentCustom<D> extends AnnotationSegmentCustom<D> {
  D startValue;
  D endValue;
  final bool isShowLineStart;
  final bool isShowLineEnd;
  final double lengthLineStart;
  final double lengthLineEnd;
  final Color colorLine;

  RangeAnnotationSegmentCustom(
      this.startValue,
      this.endValue,
      this.isShowLineStart,
      this.isShowLineEnd,
      this.lengthLineStart,
      this.lengthLineEnd,
      this.colorLine,
      RangeAnnotationAxisTypeCustom axisType,
      {String? axisId,
      Color? color,
      IconData? startLabel,
      IconData? endLabel,
      IconData? middleLabel,
      AnnotationLabelAnchorCustom? labelAnchor,
      AnnotationLabelDirectionCustom? labelDirection,
      AnnotationLabelPositionCustom? labelPosition,
      TextStyleSpec? labelStyleSpec})
      : super(axisType,
            axisId: axisId,
            color: color,
            startLabel: startLabel,
            endLabel: endLabel,
            middleLabel: middleLabel,
            labelAnchor: labelAnchor,
            labelDirection: labelDirection,
            labelPosition: labelPosition,
            labelStyleSpec: labelStyleSpec);

  @override
  String get key =>
      'r::${axisType}::${axisId}::${startValue}::${endValue}::${isShowLineStart}::${isShowLineEnd}::${lengthLineStart}::${lengthLineEnd}::${colorLine}';
}

/// Data for a chart line annotation.
class LineAnnotationSegmentCustom<D> extends AnnotationSegmentCustom<D> {
  final D value;
  final List<int>? dashPattern;
  final double strokeWidthPx;

  LineAnnotationSegmentCustom(
      this.value, RangeAnnotationAxisTypeCustom axisType,
      {String? axisId,
      Color? color,
      IconData? startLabel,
      IconData? endLabel,
      IconData? middleLabel,
      AnnotationLabelAnchorCustom? labelAnchor,
      AnnotationLabelDirectionCustom? labelDirection,
      AnnotationLabelPositionCustom? labelPosition,
      TextStyleSpec? labelStyleSpec,
      this.dashPattern,
      this.strokeWidthPx = _defaultStrokeWidthPx})
      : super(axisType,
            axisId: axisId,
            color: color,
            startLabel: startLabel,
            endLabel: endLabel,
            middleLabel: middleLabel,
            labelAnchor: labelAnchor,
            labelDirection: labelDirection,
            labelPosition: labelPosition,
            labelStyleSpec: labelStyleSpec);

  @override
  String get key => 'l::${axisType}::${axisId}::${value}';
}

/// Axis type for an annotation.
enum RangeAnnotationAxisTypeCustom {
  domain,
  measure,
}

/// Configures where to anchor the label.
enum AnnotationLabelAnchorCustom {
  /// Anchor to the starting side of the annotation range.
  start,

  /// Anchor to the middle of the annotation range.
  middle,

  /// Anchor to the ending side of the annotation range.
  end,
}

/// Direction of the label text on the chart.
enum AnnotationLabelDirectionCustom {
  /// Automatically assign a direction based on the [RangeAnnotationAxisTypeCustom].
  ///
  /// [horizontal] for measure axes, or [vertical] for domain axes.
  auto,

  /// Text flows parallel to the x axis.
  horizontal,

  /// Text flows parallel to the y axis.
  /// TODO[b/112553019]: Implement vertical text rendering of labels.
  vertical,
}

/// Configures where to place the label relative to the annotation.
enum AnnotationLabelPositionCustom {
  /// Automatically try to place the label inside the bar first and place it on
  /// the outside of the space available outside the bar is greater than space
  /// available inside the bar.
  auto,

  /// Always place label on the outside.
  outside,

  /// Always place label on the inside.
  inside,

  /// Place the label outside of the draw area, in the chart margin.
  ///
  /// Labels will be rendered on the opposite side of the chart from the primary
  /// axis. For measure annotations, this means the "end" side, opposite from
  /// the "start" side where the primary measure axis is located.
  ///
  /// This should not be used for measure annotations if the chart has a
  /// secondary measure axis. The annotation behaviors do not perform collision
  /// detection with tick labels.
  margin,
}

const String _unresolvedAutoMessage = 'Unresolved AnnotationLabelPosition.auto';
