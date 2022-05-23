


import 'package:wecheck/model/input_email_data.dart';
import 'package:wecheck/services/api/api_service.dart';

class InputEmailRepository {
  ApiService apiService = ApiService();

  Future<InputEmailEntity> callInputEmailResponse(String pinCodeText){

    return Future.value(InputEmailEntity());
  }
}