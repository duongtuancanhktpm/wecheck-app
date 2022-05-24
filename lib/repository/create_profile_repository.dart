import 'package:wecheck/model/create_profile_data.dart';
import 'package:wecheck/services/api/api_service.dart';

class CreateProfileRepository {
  ApiService apiService = ApiService();

  Future<CreateProfileResponse> callInputCode(CreateProfileData pinCodeText){

    return Future.value(CreateProfileResponse());
  }
}
