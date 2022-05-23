
import 'package:wecheck/model/set_password_data.dart';
import 'package:wecheck/services/api/api_service.dart';

class SetPasswordRepository {
  ApiService apiService = ApiService();

  Future<SetPasswordEntity> callSetPassword(String passwordText){

    return Future.value(SetPasswordEntity());
  }
}