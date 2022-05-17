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

import 'dart:ffi';
import 'dart:math' show Point, Rectangle, max;
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:wecheck/flutter_chart/charts/flutter.dart' as charts;

import 'package:wecheck/flutter_chart/common/common.dart' as common
    show
        BlendMode,
        ChartCanvas,
        CanvasBarStack,
        CanvasPie,
        Color,
        FillPatternType,
        GraphicsFactory,
        Link,
        LinkOrientation,
        StyleFactory,
        TextElement,
        TextDirection;
import 'package:flutter/material.dart';

import 'canvas/circle_sector_painter.dart' show CircleSectorPainter;
import 'canvas/line_painter.dart' show LinePainter;
import 'canvas/pie_painter.dart' show PiePainter;
import 'canvas/point_painter.dart' show PointPainter;
import 'canvas/polygon_painter.dart' show PolygonPainter;
import 'text_element.dart' show TextElement;

class ChartCanvas implements common.ChartCanvas {
  /// Pixels to allow to overdraw above the draw area that fades to transparent.
  static const double rect_top_gradient_pixels = 5;

  final Canvas canvas;
  final common.GraphicsFactory graphicsFactory;
  final _paint = new Paint();

  ChartCanvas(this.canvas, this.graphicsFactory);

  @override
  void drawCircleSector(Point center, double radius, double innerRadius,
      double startAngle, double endAngle,
      {common.Color? fill, common.Color? stroke, double? strokeWidthPx}) {
    CircleSectorPainter.draw(
      canvas: canvas,
      paint: _paint,
      center: center,
      radius: radius,
      innerRadius: innerRadius,
      startAngle: startAngle,
      endAngle: endAngle,
      fill: fill,
    );
  }

  @override
  void drawLink(
      common.Link link, common.LinkOrientation orientation, common.Color fill) {
    // TODO: Implement drawLink for flutter.
    throw ("Flutter drawLink() has not been implemented.");
  }

  @override
  void drawLine(
      {required List<Point> points,
      Rectangle<num>? clipBounds,
      common.Color? fill,
      common.Color? stroke,
      bool? smoothLine,
      bool? roundEndCaps,
      double? strokeWidthPx,
      List<int>? dashPattern}) {
    LinePainter.draw(
        canvas: canvas,
        paint: _paint,
        points: points,
        clipBounds: clipBounds,
        fill: fill,
        stroke: stroke,
        smoothLine: smoothLine,
        roundEndCaps: roundEndCaps,
        strokeWidthPx: strokeWidthPx,
        dashPattern: dashPattern);
  }

  @override
  void drawPie(common.CanvasPie canvasPie) {
    PiePainter.draw(canvas, _paint, canvasPie);
  }

  @override
  void drawPoint(
      {required Point<num> point,
      required double radius,
      charts.Color? fill,
      charts.Color? stroke,
      double? strokeWidthPx,
      common.BlendMode? blendMode,
      bool? smoothLine}) {
    PointPainter.draw(
        canvas: canvas,
        paint: _paint,
        point: point,
        radius: radius,
        fill: fill,
        stroke: stroke,
        strokeWidthPx: strokeWidthPx);
  }

  @override
  void drawPolygon(
      {required List<Point> points,
      Rectangle<num>? clipBounds,
      common.Color? fill,
      common.Color? stroke,
      double? strokeWidthPx,
      bool smoothLine = false}) {
    PolygonPainter.draw(
        canvas: canvas,
        paint: _paint,
        points: points,
        clipBounds: clipBounds,
        fill: fill,
        stroke: stroke,
        strokeWidthPx: strokeWidthPx,
        smoothLine: smoothLine);
  }

  /// Creates a bottom to top gradient that transitions [fill] to transparent.
  ui.Gradient _createHintGradient(double left, double top, common.Color fill) {
    return new ui.Gradient.linear(
      new Offset(left, top),
      new Offset(left, top - rect_top_gradient_pixels),
      [
        new Color.fromARGB(fill.a, fill.r, fill.g, fill.b),
        new Color.fromARGB(0, fill.r, fill.g, fill.b)
      ],
    );
  }

  @override
  void drawRect(Rectangle<num> bounds,
      {common.Color? fill,
      common.FillPatternType? pattern,
      common.Color? stroke,
      double? strokeWidthPx,
      Rectangle<num>? drawAreaBounds}) {
    // TODO: remove this explicit `bool` type when no longer needed
    // to work around https://github.com/dart-lang/language/issues/1785
    final bool drawStroke =
        (strokeWidthPx != null && strokeWidthPx > 0.0 && stroke != null);

    final strokeWidthOffset = (drawStroke ? strokeWidthPx : 0);

    // Factor out stroke width, if a stroke is enabled.
    final fillRectBounds = Rectangle<num>(
        bounds.left + strokeWidthOffset / 2,
        bounds.top + strokeWidthOffset / 2,
        bounds.width - strokeWidthOffset,
        bounds.height - strokeWidthOffset);

    switch (pattern) {
      case common.FillPatternType.forwardHatch:
        _drawForwardHatchPattern(fillRectBounds, canvas,
            fill: fill!, drawAreaBounds: drawAreaBounds);
        break;

      case common.FillPatternType.solid:
      default:
        // Use separate rect for drawing stroke
        _paint.color = new Color.fromARGB(fill!.a, fill.r, fill.g, fill.b);
        _paint.style = PaintingStyle.fill;

        // Apply a gradient to the top [rect_top_gradient_pixels] to transparent
        // if the rectangle is higher than the [drawAreaBounds] top.
        if (drawAreaBounds != null && bounds.top < drawAreaBounds.top) {
          _paint.shader = _createHintGradient(drawAreaBounds.left.toDouble(),
              drawAreaBounds.top.toDouble(), fill);
        }

        canvas.drawRect(_getRect(fillRectBounds), _paint);
        break;
    }

    // [Canvas.drawRect] does not support drawing a rectangle with both a fill
    // and a stroke at this time. Use a separate rect for the stroke.
    if (drawStroke) {
      _paint.color = new Color.fromARGB(stroke.a, stroke.r, stroke.g, stroke.b);
      // Set shader to null if no draw area bounds so it can use the color
      // instead.
      _paint.shader = drawAreaBounds != null
          ? _createHintGradient(drawAreaBounds.left.toDouble(),
              drawAreaBounds.top.toDouble(), stroke)
          : null;
      _paint.strokeJoin = StrokeJoin.round;
      _paint.strokeWidth = strokeWidthPx;
      _paint.style = PaintingStyle.stroke;

      canvas.drawRect(_getRect(bounds), _paint);
    }

    // Reset the shader.
    _paint.shader = null;
  }

  @override
  void drawRRect(Rectangle<num> bounds,
      {common.Color? fill,
      common.Color? stroke,
      common.Color? patternColor,
      common.FillPatternType? fillPattern,
      double? patternStrokeWidthPx,
      double? strokeWidthPx,
      num? radius,
      bool roundTopLeft = false,
      bool roundTopRight = false,
      bool roundBottomLeft = false,
      bool roundBottomRight = false}) {
    // Use separate rect for drawing stroke
    _paint.color = new Color.fromARGB(fill!.a, fill.r, fill.g, fill.b);
    _paint.style = PaintingStyle.fill;

    canvas.drawRRect(
        _getRRect(bounds,
            radius: radius?.toDouble() ?? 0.0,
            roundTopLeft: roundTopLeft,
            roundTopRight: roundTopRight,
            roundBottomLeft: roundBottomLeft,
            roundBottomRight: roundBottomRight),
        _paint);
  }

  @override
  void drawBarStack(common.CanvasBarStack barStack,
      {Rectangle<num>? drawAreaBounds}) {
    // only clip if rounded rect.

    // Clip a rounded rect for the whole region if rounded bars.
    final roundedCorners = barStack.radius != null && 0 < barStack.radius!;

    if (roundedCorners) {
      canvas
        ..save()
        ..clipRRect(_getRRect(
          barStack.fullStackRect,
          radius: barStack.radius!.toDouble(),
          roundTopLeft: barStack.roundTopLeft,
          roundTopRight: barStack.roundTopRight,
          roundBottomLeft: barStack.roundBottomLeft,
          roundBottomRight: barStack.roundBottomRight,
        ));
    }

    // Draw each bar.
    for (var barIndex = 0; barIndex < barStack.segments.length; barIndex++) {
      // TODO: Add configuration for hiding stack line.
      // TODO: Don't draw stroke on bottom of bars.
      final segment = barStack.segments[barIndex];
      drawRect(segment.bounds,
          fill: segment.fill,
          pattern: segment.pattern,
          stroke: segment.stroke,
          strokeWidthPx: segment.strokeWidthPx,
          drawAreaBounds: drawAreaBounds);
    }

    if (roundedCorners) {
      canvas.restore();
    }
  }

  @override
  void drawText(common.TextElement textElement, int offsetX, int offsetY,
      {double rotation = 0.0}) {
    // Must be Flutter TextElement.
    assert(textElement is TextElement);

    final flutterTextElement = textElement as TextElement;
    final textDirection = flutterTextElement.textDirection;
    final measurement = flutterTextElement.measurement;

    if (rotation != 0) {
      // TODO: Remove once textAnchor works.
      if (textDirection == common.TextDirection.rtl) {
        offsetY += measurement.horizontalSliceWidth.toInt();
      }

      offsetX -= flutterTextElement.verticalFontShift;

      canvas.save();
      canvas.translate(offsetX.toDouble(), offsetY.toDouble());
      canvas.rotate(rotation);
      if (textElement.text != 'M1') {
        textElement.textPainter!.paint(canvas, new Offset(0.0, 0.0));
      }
      canvas.restore();
    } else {
      // TODO: Remove once textAnchor works.
      if (textDirection == common.TextDirection.rtl) {
        offsetX -= measurement.horizontalSliceWidth.toInt();
      }

      // Account for missing center alignment.
      if (textDirection == common.TextDirection.center) {
        offsetX -= (measurement.horizontalSliceWidth / 2).ceil();
      }

      offsetY -= flutterTextElement.verticalFontShift;

      if (textElement.text != 'M1') {
        textElement.textPainter!
            .paint(canvas, new Offset(offsetX.toDouble(), offsetY.toDouble()));
      }
    }
  }

  @override
  void setClipBounds(Rectangle<int> clipBounds) {
    canvas
      ..save()
      ..clipRect(_getRect(clipBounds));
  }

  @override
  void resetClipBounds() {
    canvas.restore();
  }

  /// Convert dart:math [Rectangle] to Flutter [Rect].
  Rect _getRect(Rectangle<num> rectangle) {
    return new Rect.fromLTWH(
        rectangle.left.toDouble(),
        rectangle.top.toDouble(),
        rectangle.width.toDouble(),
        rectangle.height.toDouble());
  }

  /// Convert dart:math [Rectangle] and to Flutter [RRect].
  RRect _getRRect(
    Rectangle<num> rectangle, {
    double radius = 0,
    bool roundTopLeft = false,
    bool roundTopRight = false,
    bool roundBottomLeft = false,
    bool roundBottomRight = false,
  }) {
    final cornerRadius =
        radius == 0 ? Radius.zero : new Radius.circular(radius);

    return new RRect.fromLTRBAndCorners(
        rectangle.left.toDouble(),
        rectangle.top.toDouble(),
        rectangle.right.toDouble(),
        rectangle.bottom.toDouble(),
        topLeft: roundTopLeft ? cornerRadius : Radius.zero,
        topRight: roundTopRight ? cornerRadius : Radius.zero,
        bottomLeft: roundBottomLeft ? cornerRadius : Radius.zero,
        bottomRight: roundBottomRight ? cornerRadius : Radius.zero);
  }

  /// Draws a forward hatch pattern in the given bounds.
  _drawForwardHatchPattern(
    Rectangle<num> bounds,
    Canvas canvas, {
    common.Color? background,
    common.Color? fill,
    double fillWidthPx = 4.0,
    Rectangle<num>? drawAreaBounds,
  }) {
    background ??= common.StyleFactory.style.white;
    fill ??= common.StyleFactory.style.black;

    // Fill in the shape with a solid background color.
    _paint.color = new Color.fromARGB(
        background.a, background.r, background.g, background.b);
    _paint.style = PaintingStyle.fill;

    // Apply a gradient the background if bounds exceed the draw area.
    if (drawAreaBounds != null && bounds.top < drawAreaBounds.top) {
      _paint.shader = _createHintGradient(drawAreaBounds.left.toDouble(),
          drawAreaBounds.top.toDouble(), background);
    }

    canvas.drawRect(_getRect(bounds), _paint);

    // As a simplification, we will treat the bounds as a large square and fill
    // it up with lines from the bottom-left corner to the top-right corner.
    // Get the longer side of the bounds here for the size of this square.
    final size = max(bounds.width, bounds.height);

    final x0 = bounds.left + size + fillWidthPx;
    final x1 = bounds.left - fillWidthPx;
    final y0 = bounds.bottom - size - fillWidthPx;
    final y1 = bounds.bottom + fillWidthPx;
    final offset = 8;

    final isVertical = bounds.height >= bounds.width;

    // The "first" line segment will be drawn from the bottom left corner of the
    // bounds, up and towards the right. Start the loop N iterations "back" to
    // draw partial line segments beneath (or to the left) of this segment,
    // where N is the number of offsets that fit inside the smaller dimension of
    // the bounds.
    final smallSide = isVertical ? bounds.width : bounds.height;
    final start = -(smallSide / offset).round() * offset;

    // Keep going until we reach the top or right of the bounds, depending on
    // whether the rectangle is oriented vertically or horizontally.
    final end = size + offset;

    // Create gradient for line painter if top bounds exceeded.
    ui.Shader? lineShader;
    if (drawAreaBounds != null && bounds.top < drawAreaBounds.top) {
      lineShader = _createHintGradient(
          drawAreaBounds.left.toDouble(), drawAreaBounds.top.toDouble(), fill);
    }

    for (int i = start; i < end; i = i + offset) {
      // For vertical bounds, we need to draw lines from top to bottom. For
      // bounds, we need to draw lines from left to right.
      final modifier = isVertical ? -1 * i : i;

      // Draw a line segment in the bottom right corner of the pattern.
      LinePainter.draw(
          canvas: canvas,
          paint: _paint,
          points: [
            new Point(x0 + modifier, y0),
            new Point(x1 + modifier, y1),
          ],
          stroke: fill,
          strokeWidthPx: fillWidthPx,
          shader: lineShader);
    }
  }

  @override
  set drawingView(String? viewName) {}

  @override
  void drawIcon(Rectangle<num> bounds,
      {common.Color? fill,
      common.FillPatternType? pattern,
      common.Color? stroke,
      double? strokeWidthPx,
      Rectangle<num>? drawAreaBounds}) {
    // TODO: remove this explicit `bool` type when no longer needed
    // to work around https://github.com/dart-lang/language/issues/1785
    final bool drawStroke =
        (strokeWidthPx != null && strokeWidthPx > 0.0 && stroke != null);

    final strokeWidthOffset = (drawStroke ? strokeWidthPx : 0);

    // Factor out stroke width, if a stroke is enabled.
    final fillRectBounds = Rectangle<num>(
        bounds.left + strokeWidthOffset / 2,
        bounds.top + strokeWidthOffset / 2,
        bounds.width - strokeWidthOffset,
        bounds.height - strokeWidthOffset);

    switch (pattern) {
      case common.FillPatternType.forwardHatch:
        _drawForwardHatchPattern(fillRectBounds, canvas,
            fill: fill!, drawAreaBounds: drawAreaBounds);
        break;

      case common.FillPatternType.solid:
      default:
        // Use separate rect for drawing stroke
        _paint.color = new Color.fromARGB(fill!.a, fill.r, fill.g, fill.b);
        _paint.style = PaintingStyle.fill;

        // Apply a gradient to the top [rect_top_gradient_pixels] to transparent
        // if the rectangle is higher than the [drawAreaBounds] top.
        if (drawAreaBounds != null && bounds.top < drawAreaBounds.top) {
          _paint.shader = _createHintGradient(drawAreaBounds.left.toDouble(),
              drawAreaBounds.top.toDouble(), fill);
        }

        // final colors = [
        //   Color(0xffff0000), Color(0xffffff00), Color(0xff00ff00),
        //   Color(0xff00ffff), Color(0xff0000ff), Color(0xffff00ff), Color(0xffff0000),
        // ];

        showIconRect(bounds, strokeWidthOffset);

        //canvas.drawImage(Image.asset('name'), Offset(bounds.left + strokeWidthOffset / 2, bounds.top + strokeWidthOffset / 2,), _paint);
        // canvas.drawCircle(Offset.zero,5.0, _paint);
        // canvas.drawParagraph(para, Offset.zero);

        // canvas.drawRect(_getRect(fillRectBounds), _paint);
        break;
    }

    // [Canvas.drawRect] does not support drawing a rectangle with both a fill
    // and a stroke at this time. Use a separate rect for the stroke.
    if (drawStroke) {
      _paint.color = new Color.fromARGB(stroke.a, stroke.r, stroke.g, stroke.b);
      // Set shader to null if no draw area bounds so it can use the color
      // instead.
      _paint.shader = drawAreaBounds != null
          ? _createHintGradient(drawAreaBounds.left.toDouble(),
              drawAreaBounds.top.toDouble(), stroke)
          : null;
      _paint.strokeJoin = StrokeJoin.round;
      _paint.strokeWidth = strokeWidthPx;
      _paint.style = PaintingStyle.stroke;

      canvas.drawRect(_getRect(bounds), _paint);

      // const icon = Icons.add;
      // var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      //   fontFamily: icon.fontFamily,
      // ))
      //   ..addText(String.fromCharCode(icon.codePoint));
      // var para = builder.build();
      // para.layout(const ui.ParagraphConstraints(width: 60));
      // canvas.drawParagraph(para, const Offset(20, 20));

    }

    // Reset the shader.
    _paint.shader = null;
  }

  void showIconRect(var bounds, var strokeWidthOffset) {
    final gradient = ui.Gradient.linear(
      Offset(0.0, 0.0),
      Offset(0.0, 30),
      colors,
      colorStops,
    );
    final gradientPaint = new Paint()..shader = gradient;

    const icon = Icons.directions_walk;
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      fontFamily: icon.fontFamily,
    ))
      ..pushStyle(ui.TextStyle(foreground: gradientPaint))
      ..addText(String.fromCharCode(icon.codePoint));
    var para = builder.build();
    para.layout(const ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(
        para,
        Offset(
          bounds.left + strokeWidthOffset / 2,
          bounds.top + strokeWidthOffset / 2,
        ));
  }

  @override
  void drawIconText(
      common.TextElement textElement,
      IconData icon,
      bool isShowLineStart,
      bool isShowLineEnd,
      double lengthLineStart,
      double lengthLineEnd,
      common.Color colorLine,
      int offsetX,
      int offsetY,
      {double rotation = 0.0}) {
    assert(textElement is TextElement);

    final flutterTextElement = textElement as TextElement;
    final textDirection = flutterTextElement.textDirection;
    final measurement = flutterTextElement.measurement;

    if (rotation != 0) {
      // TODO: Remove once textAnchor works.
      if (textDirection == common.TextDirection.rtl) {
        offsetY += measurement.horizontalSliceWidth.toInt();
      }

      offsetX -= flutterTextElement.verticalFontShift;

      canvas.save();
      canvas.translate(offsetX.toDouble(), offsetY.toDouble());
      canvas.rotate(rotation);

      // textElement.textPainter!.paint(canvas, new Offset(0.0, 0.0));

      if (textElement.text == 'M1') {
        showIcon(icon, offsetX, offsetY, isShowLineStart, lengthLineStart,
            colorLine);
      } else if (textElement.text == 'M2') {
        showIcon(
            icon, offsetX, offsetY, isShowLineEnd, lengthLineEnd, colorLine);
      }

      canvas.restore();
    } else {
      // TODO: Remove once textAnchor works.
      if (textDirection == common.TextDirection.rtl) {
        offsetX -= measurement.horizontalSliceWidth.toInt();
      }

      // Account for missing center alignment.
      if (textDirection == common.TextDirection.center) {
        offsetX -= (measurement.horizontalSliceWidth / 2).ceil();
      }

      offsetY -= flutterTextElement.verticalFontShift;

      // textElement.textPainter!
      //     .paint(canvas, new Offset(offsetX.toDouble(), offsetY.toDouble()));

      if (textElement.text == 'M1') {
        showIcon(icon, offsetX, offsetY, isShowLineStart, lengthLineStart,
            colorLine);
      } else if (textElement.text == 'M2') {
        showIcon(
            icon, offsetX, offsetY, isShowLineEnd, lengthLineEnd, colorLine);
      }
    }
  }

  final colors = [
    const Color(0xff295AB6),
    Color(0xff295AB6),
    Color(0xff295AB6),
    Color(0xff295AB6),
    Color(0xff295AB6),
    Color(0xff295AB6),
    Color(0xff295AB6),
  ];
  final colorStops = [0 / 6, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 6 / 6];

  void showIcon(var icon, var offsetX, var offsetY, bool isShowLine,
      double lengthLine, common.Color colorLine) {
    final gradient = ui.Gradient.linear(
      const Offset(0.0, 0.0),
      const Offset(0.0, 0.0),
      colors,
      colorStops,
    );
    final gradientPaint = Paint()..shader = gradient;

    var builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(fontFamily: icon.fontFamily, fontSize: 20))
      ..pushStyle(ui.TextStyle(foreground: gradientPaint))
      ..addText(String.fromCharCode(icon.codePoint));
    var para = builder.build();
    para.layout(const ui.ParagraphConstraints(width: 22));

    if (isShowLine) {
      var physicalScreenSize = window.physicalSize;
      var safeWidth = physicalScreenSize.width;
      var safeHeight = physicalScreenSize.height;

      double lengthLineUse = 0;
      if (lengthLine == 0) {
        lengthLineUse = 0;
      } else {
        if (safeWidth < safeHeight) {
          lengthLineUse = ((safeWidth / 20) * lengthLine / 8);
        } else {
          lengthLineUse = ((safeWidth / 20) * lengthLine / 5);
        }
      }
      print('DDRRR $lengthLineUse ${offsetX.toDouble()}');
      // quannh edited 12/04/2022 vẽ line ở trên đầu chart

      LinePainter.draw(
        canvas: canvas,
        paint: _paint,
        points: [
          Point(offsetX.toDouble() - lengthLineUse + 6, offsetY.toDouble() + 5),
          Point(offsetX.toDouble() + 12, offsetY.toDouble() + 5)
        ],
        stroke: colorLine,
        roundEndCaps: true,
        strokeWidthPx: 25.0,
      );
    }
    // quannh edited 8/04/2022 vẽ icon ở trên đầu chart
    canvas.drawParagraph(
        para, Offset(offsetX.toDouble(), offsetY.toDouble() - 5));
  }
}
