import 'package:wecheck/model/figures_health_data.dart';
import 'package:wecheck/model/health_data.dart';

class BloodSugarLogRepository {
  Future<List<HealthData>> doGetListHealthData() {
    final List<HealthData> healthEvent = [
      HealthData(DateTime(2022, 05, 06), [
        FiguresHealthData(1, 120, 1),
        FiguresHealthData(1, 120, 3),
        FiguresHealthData(1, 120, 4),
        FiguresHealthData(1, 120, 5),
        FiguresHealthData(1, 120, 6),
      ]),
      HealthData(DateTime(2022, 04, 06), [
        FiguresHealthData(1, 120, 1),
        FiguresHealthData(1, 120, 3),
      ])
    ];
    return Future.value(healthEvent);
  }
}