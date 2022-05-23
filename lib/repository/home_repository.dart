import 'package:wecheck/flutter_chart/charts/flutter.dart' as charts;
import 'package:wecheck/model/home/chart_entity.dart';
import 'package:wecheck/services/api/api_service.dart';

class HomeRepository {
  ApiService apiService = ApiService();

  Future<List<charts.Series<LinearSales, int>>> callDataHome(
      HomeData homeData) {
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

    var arrr = [
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

    return Future.value(arrr);
  }
}
