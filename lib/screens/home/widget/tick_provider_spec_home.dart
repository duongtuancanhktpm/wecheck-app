import 'package:wecheck/flutter_chart/charts/flutter.dart' as charts;

charts.StaticNumericTickProviderSpec
tickProviderSpecDomainAxisHome() {
  return const charts.StaticNumericTickProviderSpec(
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
  );
}

charts.StaticNumericTickProviderSpec
tickProviderSpecPrimaryMeasureAxisHome() {
  return const charts.StaticNumericTickProviderSpec(
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
  );
}

charts.StaticNumericTickProviderSpec
tickProviderSpecSecondaryMeasureAxisHome() {
  return const charts.StaticNumericTickProviderSpec(
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
  );
}
