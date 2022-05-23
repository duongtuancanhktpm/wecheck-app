import 'package:wecheck/model/sign_in_data.dart';
import 'package:wecheck/services/api/api_service.dart';

class SignInRepository {
  ApiService apiService = ApiService();

  Future<SignInEntity> callLogin(var username, var password) {
    return Future.value(SignInEntity());
  }
}
