import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecheck/flutter_chart/chart_app_icons.dart';
import 'package:wecheck/flutter_chart/charts/flutter.dart' as charts;
import 'package:wecheck/flutter_chart/common/src/common/symbol_renderer.dart';
import 'package:wecheck/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool changed = false;
  var valueShow = CustomCircleSymbolRenderer('44').obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [_homeChart()],
            )
          ],
        ),
      ),
    );
  }

  Widget _homeChart() {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 1, right: 1),
            height: 220,
            child: Obx(() => Stack(
                  children: [
                    //SmoothLineChart.withRandomData(),
                    charts.NumericComboChart(
                      _createSampleData2(),
                      domainAxis: charts.NumericAxisSpec(
                          renderSpec: charts.GridlineRendererSpec(
                              lineStyle: charts.LineStyleSpec(
                            color: charts.MaterialPalette.gray.shade200,
                            thickness: 1,
                          )),
                          tickProviderSpec:
                              const charts.StaticNumericTickProviderSpec(
                            <charts.TickSpec<num>>[
                              charts.TickSpec(0,
                                  label: '03:00',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(3,
                                  label: '',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(6,
                                  label: '9:00',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(9,
                                  label: '',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(12,
                                  label: '15:00',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(15,
                                  label: '',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(18,
                                  label: '21:00',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(21,
                                  label: '',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(24,
                                  label: '3:00',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                            ],
                          )),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                          renderSpec: charts.GridlineRendererSpec(
                              labelOffsetFromAxisPx: -20,
                              labelAnchor: charts.TickLabelAnchor.after,
                              lineStyle: charts.LineStyleSpec(
                                color: charts.MaterialPalette.gray.shade200,
                                thickness: 1,
                              )),
                          tickProviderSpec:
                              const charts.StaticNumericTickProviderSpec(
                            // Create the ticks to be used the domain axis.
                            <charts.TickSpec<num>>[
                              charts.TickSpec(300,
                                  label: '300',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(200,
                                  label: '200',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(100,
                                  label: '100',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                            ],
                          )),
                      secondaryMeasureAxis: charts.NumericAxisSpec(
                          renderSpec: charts.GridlineRendererSpec(
                              labelOffsetFromAxisPx: -20,
                              labelAnchor: charts.TickLabelAnchor.after,
                              lineStyle: charts.LineStyleSpec(
                                color: charts.MaterialPalette.gray.shade200,
                                thickness: 1,
                              )),
                          tickProviderSpec:
                              const charts.StaticNumericTickProviderSpec(
                            // Create the ticks to be used the domain axis.
                            <charts.TickSpec<num>>[
                              charts.TickSpec(6000,
                                  label: '6000',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(4000,
                                  label: '4000',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(2000,
                                  label: '2000',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                              charts.TickSpec(0,
                                  label: '',
                                  style: charts.TextStyleSpec(fontSize: 10)),
                            ],
                          )),
                      animate: true,
                      defaultRenderer: charts.LineRendererConfig(
                        includePoints: true,
                        symbolRenderer: charts.RectSymbolRenderer(),
                      ),
                      customSeriesRenderers: [
                        charts.BarRendererConfig(customRendererId: 'customBar'),
                        charts.LineRendererConfig(
                            smoothLine: true, customRendererId: 'SmoothLine'),
                      ],
                      behaviors: listBehaviors(),
                      selectionModels: [
                        charts.SelectionModelConfig(
                            changedListener: (charts.SelectionModel model) {
                          if (model.hasDatumSelection) {
                            if (model.selectedDatum.length >= 2) {
                              valueShow.value.valueShow =
                                  '${model.selectedDatum[1].series.data[model.selectedDatum[1].index!].sales}';
                            } else {
                              valueShow.value.valueShow =
                                  '${model.selectedSeries[0].data[model.selectedDatum[0].index!].sales}';
                            }
                          }
                        })
                      ],
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData2() {
    final desktopSalesDataColumn = [
      LinearSales(3, 50, [2, 2]),
      LinearSales(4, 25, [2, 2]),
      LinearSales(5, 0, [2, 2]),
      LinearSales(6, 75, [2, 2]),
      LinearSales(7, 0, [2, 2]),
      LinearSales(8, 45, [2, 2]),
      LinearSales(9, 85, [2, 2]),
      LinearSales(10, 35, [2, 2]),
      LinearSales(11, 0, [2, 2]),
      LinearSales(12, 0, [2, 2]),
      LinearSales(13, 0, [2, 2]),
      LinearSales(14, 0, [2, 2]),
      LinearSales(15, 35, [2, 2]),
      LinearSales(16, 65, [2, 2]),
      LinearSales(17, 25, [2, 2]),
      LinearSales(18, 15, [2, 2]),
      LinearSales(19, 0, [2, 2]),
      LinearSales(20, 0, [2, 2]),
      LinearSales(21, 0, [2, 2]),
    ];

    final mobileSalesDataLine = [
      LinearSales(0, 30, [2, 2]),
      LinearSales(5, 50, [2, 2]),
      LinearSales(8, 80, [2, 2]),
      LinearSales(10, 250, [2, 2]),
      LinearSales(15, 80, [2, 2]),
      LinearSales(18, 200, [2, 2]),
    ];

    var mobileSalesDateFutureLine = [
      LinearSales(18, 200, [2, 2]),
      LinearSales(21, 160, [2, 2]),
      LinearSales(24, 180, [2, 2]),
    ];

    final dataSmoothLine = [
      LinearSales(0, 130, [2, 2]),
      LinearSales(5, 150, [2, 2]),
      LinearSales(8, 180, [2, 2]),
      LinearSales(10, 250, [2, 2]),
      LinearSales(15, 180, [2, 2]),
      LinearSales(18, 200, [2, 2]),
      LinearSales(21, 60, [2, 2]),
      LinearSales(24, 80, [2, 2]),
    ];

    final globalSalesDataValueColumnRight = [
      LinearSales(0, 5000, [2, 2])
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.gray300,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: desktopSalesDataColumn,
      )..setAttribute(charts.rendererIdKey, 'customBar'),

      charts.Series<LinearSales, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.blue300,
        dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: mobileSalesDateFutureLine,
      ),

      charts.Series<LinearSales, int>(
        id: 'SmoothLineFF',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        strokeWidthPxFn: (LinearSales sales, _) => 1.0,
        data: dataSmoothLine,
      )..setAttribute(charts.rendererIdKey, 'SmoothLine'),

      charts.Series<LinearSales, int>(
          id: 'Mobile',
          colorFn: (_, __) => charts.MaterialPalette.blue900,
          fillColorFn: (LinearSales sales, __) => sales.sales > 180
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.blue900,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: mobileSalesDataLine),
      // ..setAttribute(charts.rendererIdKey, 'customBar'),

      charts.Series<LinearSales, int>(
        id: 'Los Angeles Revenue',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (_, __) => charts.MaterialPalette.transparent,
        data: globalSalesDataValueColumnRight,
      )..setAttribute(charts.measureAxisIdKey, 'secondaryMeasureAxisId'),
    ];
  }

  List<charts.ChartBehavior<num>>? listBehaviors() {
    return [
      charts.LinePointHighlighter(
          symbolRenderer: valueShow.value,
          drawFollowLinesAcrossChart: true,
          showVerticalFollowLine:
              charts.LinePointHighlighterFollowLineType.all),
      charts.RangeAnnotationCustom([
        charts.RangeAnnotationSegmentCustom(
            3,
            13,
            true,
            true,
            3,
            0,
            charts.MaterialPalette.blue100,
            charts.RangeAnnotationAxisTypeCustom.domain,
            startLabel: ChartAppIcons.utensil_spoon,
            endLabel: null,
            labelAnchor: charts.AnnotationLabelAnchorCustom.end,
            labelDirection: charts.AnnotationLabelDirectionCustom.horizontal,
            color: charts.MaterialPalette.transparent),

        charts.RangeAnnotationSegmentCustom(
            4,
            14,
            false,
            true,
            0,
            0,
            charts.MaterialPalette.blue100,
            charts.RangeAnnotationAxisTypeCustom.domain,
            startLabel: null,
            endLabel: null,
            labelAnchor: charts.AnnotationLabelAnchorCustom.end,
            labelDirection: charts.AnnotationLabelDirectionCustom.horizontal,
            color: charts.MaterialPalette.transparent),
        //  charts.RangeAnnotationSegmentCustom(
        //      5, 15, true, true, 0, 0, charts.MaterialPalette.green.shadeDefault.lighter, charts.RangeAnnotationAxisTypeCustom.domain,
        //      startLabel: Icons.mediation,
        //      endLabel: null,
        //      labelAnchor: charts.AnnotationLabelAnchorCustom.end,
        //      labelDirection: charts.AnnotationLabelDirectionCustom.horizontal,
        //      color: charts.MaterialPalette.transparent),
        //  charts.RangeAnnotationSegmentCustom(
        //      6, 16, false, true, 0, 0, charts.MaterialPalette.blue.shadeDefault.lighter, charts.RangeAnnotationAxisTypeCustom.domain,
        //      startLabel: Icons.insert_emoticon_sharp,
        //      endLabel: null,
        //      labelAnchor: charts.AnnotationLabelAnchorCustom.end,
        //      labelDirection: charts.AnnotationLabelDirectionCustom.horizontal,
        //      color: charts.MaterialPalette.transparent),
        //   charts.RangeAnnotationSegmentCustom(
        //      7, 17, true, true, 0, 0, charts.MaterialPalette.blue.shadeDefault.lighter, charts.RangeAnnotationAxisTypeCustom.domain,
        //      startLabel: null,
        //      endLabel: null,
        //      labelAnchor: charts.AnnotationLabelAnchorCustom.end,
        //      labelDirection: charts.AnnotationLabelDirectionCustom.horizontal,
        //      color: charts.MaterialPalette.transparent),
        //  charts.RangeAnnotationSegmentCustom(
        //      8, 18, true, true, 0, 3, charts.MaterialPalette.blue.shadeDefault.lighter, charts.RangeAnnotationAxisTypeCustom.domain,
        //      startLabel: null,
        //      endLabel: Icons.event_seat,
        //      labelAnchor: charts.AnnotationLabelAnchorCustom.end,
        //      labelDirection: charts.AnnotationLabelDirectionCustom.horizontal,
        //      color: charts.MaterialPalette.transparent),
        // charts.RangeAnnotationSegmentCustom(
        //      9, 19, true, true, 0, 1, charts.MaterialPalette.blue.shadeDefault.lighter, charts.RangeAnnotationAxisTypeCustom.domain,
        //      startLabel: null,
        //      endLabel: null,
        //      labelAnchor: charts.AnnotationLabelAnchorCustom.end,
        //      labelDirection: charts.AnnotationLabelDirectionCustom.horizontal,
        //      color: charts.MaterialPalette.transparent),
        //  charts.RangeAnnotationSegmentCustom(
        //      10, 20, true, true, 0, 0, charts.MaterialPalette.blue.shadeDefault.lighter, charts.RangeAnnotationAxisTypeCustom.domain,
        //      startLabel: null,
        //      endLabel: null,
        //      labelAnchor: charts.AnnotationLabelAnchorCustom.end,
        //      labelDirection: charts.AnnotationLabelDirectionCustom.horizontal,
        //      color: charts.MaterialPalette.transparent),
        //  charts.RangeAnnotationSegmentCustom(
        //      11, 21, true, true, 0, 0, charts.MaterialPalette.blue.shadeDefault.lighter, charts.RangeAnnotationAxisTypeCustom.domain,
        //      startLabel: Icons.insert_emoticon_sharp,
        //      endLabel: Icons.event_seat,
        //      labelAnchor: charts.AnnotationLabelAnchorCustom.end,
        //      labelDirection: charts.AnnotationLabelDirectionCustom.horizontal,
        //      color: charts.MaterialPalette.transparent),
        charts.RangeAnnotationSegmentCustom(
            12,
            21,
            true,
            true,
            0,
            0,
            charts.MaterialPalette.blue100,
            charts.RangeAnnotationAxisTypeCustom.domain,
            startLabel: Icons.insert_emoticon_sharp,
            endLabel: ChartAppIcons.pump_medical,
            labelAnchor: charts.AnnotationLabelAnchorCustom.end,
            labelDirection: charts.AnnotationLabelDirectionCustom.horizontal,
            color: charts.MaterialPalette.transparent),
        // charts.RangeAnnotationSegmentCustom(21, 30, false, false, 0, 0,
        //     charts.MaterialPalette.pink.shadeDefault.lighter,
        //     charts.RangeAnnotationAxisTypeCustom.domain,
        //     startLabel: null,
        //     endLabel: null,
        //     labelAnchor: charts.AnnotationLabelAnchorCustom.end,
        //     labelDirection: charts.AnnotationLabelDirectionCustom.horizontal,
        //     color: charts.MaterialPalette.pink.shadeDefault.lighter),ha
      ], defaultLabelPosition: charts.AnnotationLabelPositionCustom.margin),
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;
  final List<int> dashPattern;

  LinearSales(this.year, this.sales, this.dashPattern);
}
