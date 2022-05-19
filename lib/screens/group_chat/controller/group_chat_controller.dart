import 'package:get/get.dart';
import 'package:wecheck/model/group_chat.dart';
import 'package:wecheck/repository/group_chat_repository.dart';

class GroupChatController extends GetxController {
  var groupUsers = <GroupUser>[].obs;
  var medicalInstitutes = <MedicalInstitute>[].obs;
  var partners = <Partner>[].obs;
  var repository = GroupChatRepository();

  @override
  void onInit() {
    repository.doGetListGroupUser().then((value) => groupUsers.value = value);
    repository.doGetListMedicalInstitute().then(
          (value) => medicalInstitutes.value = value,
        );
    repository.doGetListPartner().then((value) => partners.value = value);
    super.onInit();
  }
}
