import 'package:get/get.dart';
import 'package:wecheck/model/group_chat.dart';
import 'package:wecheck/model/medical_institute.dart';
import 'package:wecheck/model/partner.dart';
import 'package:wecheck/repository/group_chat_repository.dart';

class GroupChatController extends GetxController {
  var groupUsers = <GroupUser>[].obs;
  var medicalInstitutes = <MedicalInstitute>[].obs;
  var partners = <Partner>[].obs;
  var repository = GroupChatRepository();

  @override
  void onInit() {
    repository.doGetListGroupUser().then((value) {
      if (value.isNotEmpty) {
        groupUsers.value = value;
      }
    });
    repository.doGetListMedicalInstitute().then(
      (value) {
        if (value.isNotEmpty) {
          medicalInstitutes.value = value;
        }
      },
    );
    repository.doGetListPartner().then((value) {
      if (value.isNotEmpty) {
        partners.value = value;
      }
    });
    super.onInit();
  }
}
