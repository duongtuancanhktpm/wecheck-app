import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wecheck/flutter_chart/chart_app_icons.dart';
import 'package:wecheck/flutter_chart/charts/flutter.dart' as charts;
import 'package:wecheck/flutter_chart/common/src/common/symbol_renderer.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/home/blood_sugar_model.dart';
import 'package:wecheck/model/home/insulin_model.dart';
import 'package:wecheck/model/home/meals_model.dart';
import 'package:wecheck/model/home/small_menu.dart';
import 'package:wecheck/model/home/step_model.dart';
import 'package:wecheck/screens/home/controller/home_controller.dart';
import 'package:wecheck/screens/home/widget/item_blood_sugar.dart';
import 'package:wecheck/screens/home/widget/item_grid_menu.dart';
import 'package:wecheck/screens/home/widget/item_insulin.dart';
import 'package:wecheck/screens/home/widget/item_meals.dart';
import 'package:wecheck/screens/home/widget/item_steps.dart';
import 'package:wecheck/screens/home/widget/tick_provider_spec_home.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/dimens.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/theme/text_styles.dart';

class HomeScreen extends GetView<HomeController> {
  bool changed = false;
  var valueShow = CustomCircleSymbolRenderer('44').obs;

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPattensBlue,
        title: InkWell(
          onTap: () {},
          child: Text('Sunday, April 10',
              style: AppTextStyle.t18w700(AppColors.colorCatalinaBlue)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              AppIcons.icChatUnSelected,
              width: 25.dp,
              height: 25.dp,
            ),
          )
        ],
      ),
      backgroundColor: AppColors.colorPattensBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _homeChart(context),
                  _gridMenuIndex(),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          L.current.menu.tr,
                          style:
                              AppTextStyle.t18w700(AppColors.colorCatalinaBlue),
                        ),
                      )
                    ],
                  ),
                  _gridMenu()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeChart(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => InsulinGraphHorizontalScreen()));
                controller.goToInsulinChartHorizontalScreen();
              },
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: SvgPicture.asset(
                      AppIcons.icChatUnSelected,
                      width: 20.dp,
                      height: 20.dp,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Text(
                    L.current.dailyGraph.tr,
                    style: AppTextStyle.t14w500(AppColors.colorGrey),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 1, right: 1),
              height: 200.dp,
              child: Stack(
                children: [
                  Obx(
                    () => charts.NumericComboChart(
                      controller.listDataHome.value,
                      domainAxis: charts.NumericAxisSpec(
                          renderSpec: charts.GridlineRendererSpec(
                              lineStyle: charts.LineStyleSpec(
                            color: charts.MaterialPalette.gray.shade200,
                            thickness: 1,
                          )),
                          tickProviderSpec: tickProviderSpecDomainAxisHome()),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                          renderSpec: charts.GridlineRendererSpec(
                              labelOffsetFromAxisPx: -20,
                              labelAnchor: charts.TickLabelAnchor.after,
                              lineStyle: charts.LineStyleSpec(
                                color: charts.MaterialPalette.gray.shade200,
                                thickness: 1,
                              )),
                          tickProviderSpec:
                              tickProviderSpecPrimaryMeasureAxisHome()),
                      secondaryMeasureAxis: charts.NumericAxisSpec(
                          renderSpec: charts.GridlineRendererSpec(
                              labelOffsetFromAxisPx: -20,
                              labelAnchor: charts.TickLabelAnchor.after,
                              lineStyle: charts.LineStyleSpec(
                                color: charts.MaterialPalette.gray.shade200,
                                thickness: 1,
                              )),
                          tickProviderSpec:
                              tickProviderSpecSecondaryMeasureAxisHome()),
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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

  _gridMenuIndex() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 8 / 6),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listMenuIndex.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        itemBuilder: (BuildContext context, int pos) {
          var indexEn = controller.listMenuIndex[pos];
          if (indexEn is BloodSugarEntity) {
            return itemBloodSugar();
          } else if (indexEn is MealsEntity) {
            return itemMeals();
          } else if (indexEn is InsulinEntity) {
            return itemInsulin();
          } else if (indexEn is StepEntity) {
            return itemSteps();
          }
          return Container();
        });
  }

  _gridMenu() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 7 / 5),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listMenuBottom.length,
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        itemBuilder: (BuildContext context, int pos) {
          SmallMenu indexEn = controller.listMenuBottom[pos];
          if (pos == controller.listMenuBottom.length - 1) {
            return itemMenuSmallFinal(indexEn);
          } else {
            return itemMenuSmall(indexEn);
          }
        });
  }
}
