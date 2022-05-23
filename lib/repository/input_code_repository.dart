import 'package:wecheck/model/input_code_data.dart';
import 'package:wecheck/services/api/api_service.dart';

class InputCodeRepository {
  ApiService apiService = ApiService();

  Future<InputCodeEntity> callInputCode(String pinCodeText){

    return Future.value(InputCodeEntity());
  }
}
