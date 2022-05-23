import 'package:wecheck/model/create_diabetes_data.dart';
import 'package:wecheck/services/api/api_service.dart';

class CreateDiabetesRepository {
  ApiService apiService = ApiService();

  Future<CreateDiabetesResponse> callCreateDiabetes(
      CreateDiabetesData diabetesData) {
    return Future.value(CreateDiabetesResponse());
  }
}
