import 'package:wecheck/flutter_chart/charts/flutter.dart' as charts;

charts.StaticNumericTickProviderSpec
    tickProviderSpecDomainAxisHorizontalGraph() {
  return const charts.StaticNumericTickProviderSpec(
    <charts.TickSpec<num>>[
      charts.TickSpec(0, label: '0', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(2, label: '2', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(4, label: '4', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(6, label: '6', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(8, label: '8', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(10,
          label: '10', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(12,
          label: '12', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(14,
          label: '14', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(16,
          label: '16', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(18,
          label: '18', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(20,
          label: '20', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(22,
          label: '22', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(24,
          label: '24', style: charts.TextStyleSpec(fontSize: 10)),
    ],
  );
}

charts.StaticNumericTickProviderSpec
    tickProviderSpecPrimaryMeasureAxisHorizontalGraph() {
  return const charts.StaticNumericTickProviderSpec(
    <charts.TickSpec<num>>[
      charts.TickSpec(300,
          label: '300', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(250,
          label: '250', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(200,
          label: '200', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(150,
          label: '150', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(100,
          label: '100', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(50,
          label: '50', style: charts.TextStyleSpec(fontSize: 10)),
    ],
  );
}

charts.StaticNumericTickProviderSpec
    tickProviderSpecSecondaryMeasureAxisHorizontalGraph() {
  return const charts.StaticNumericTickProviderSpec(
    // Create the ticks to be used the domain axis.
    <charts.TickSpec<num>>[
      charts.TickSpec(6000,
          label: '3000', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(5000,
          label: '2500', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(4000,
          label: '2000', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(3000,
          label: '1500', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(2000,
          label: '1000', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(1000,
          label: '500', style: charts.TextStyleSpec(fontSize: 10)),
      charts.TickSpec(0, label: '', style: charts.TextStyleSpec(fontSize: 10)),
    ],
  );
}
