import 'package:wecheck/model/group_chat.dart';

class GroupChatRepository {
  Future<List<Partner>> doGetListPartner() {
    var partners = [
      Partner(
        "https://smartyads.com/images/uploads/Boosting-ad-revenue-with-right-advertising-partnership.png",
        "Partner 1",
        "Campaign Online Briefing: Adtech Playbook – A roadmap to superior performance - Campaign Middle East",
        "2022-05-18 12:34:44",
      ),
      Partner(
        "https://1330878074.rsc.cdn77.org/wp-content/uploads/2019/09/MakeMeReach-%E2%80%93-Leading-Global-Digital-Ad-Platform-%E2%80%93-Announces-Pinterest-Partnership.jpg",
        "Partner 1",
        "Campaign Online Briefing: Adtech Playbook – A roadmap to superior performance - Campaign Middle East",
        "2022-05-18 12:34:44",
      ),
      Partner(
        "https://www.mcnuttpartners.com/assets/uploads/2021/01/1-25-21_Digital_Ads_Listening_Insta.jpg",
        "Partner 1",
        "Campaign Online Briefing: Adtech Playbook – A roadmap to superior performance - Campaign Middle East",
        "2022-05-18 12:34:44",
      )
    ];
    return Future.value(partners);
  }

  Future<List<GroupUser>> doGetListGroupUser() {
    var users = [
      GroupUser(
        [
          User("https://www.w3schools.com/howto/img_avatar.png", "People 1"),
          User("https://www.w3schools.com/w3images/avatar6.png", "People 1"),
          User("https://www.w3schools.com/w3images/avatar2.png", "People 1"),
          User("https://www.w3schools.com/howto/img_avatar2.png", "People 1"),
        ],
        "Arkey Hospital group",
        "Hello, the next chat will be on",
        "2022-05-18 12:45:00",
      ),
      GroupUser(
        [
          User("https://www.w3schools.com/howto/img_avatar.png", "People 1"),
          User("https://www.w3schools.com/w3images/avatar2.png", "People 1"),
          User("https://www.w3schools.com/howto/img_avatar2.png", "People 1"),
        ],
        "Arkey Hospital group",
        "Hello, the next chat will be on",
        "2022-05-18 12:45:00",
      )
    ];
    return Future.value(users);
  }

  Future<List<MedicalInstitute>> doGetListMedicalInstitute() {
    var medicalInstitutes = [
      MedicalInstitute(
        "https://image.shutterstock.com/z/stock-photo-modern-hospital-style-building-212251981.jpg",
        "Hospital Comples",
        "Find Hospital building stock images in HD and millions of other royalty-free stock photos, illustrations and vectors in the Shutterstock collection.",
        "2022-05-15 12:45:00",
      ),
      MedicalInstitute(
        "https://www.tibika.co.ke/images/hospital.jpg",
        "Hospital Comples",
        "Find Hospital building stock images in HD and millions of other royalty-free stock photos, illustrations and vectors in the Shutterstock collection.",
        "2022-05-15 12:45:00",
      ),
      MedicalInstitute(
        "https://hongngochospital.vn/wp-content/uploads/2021/02/benh-vien-hong-ngoc-my-dinh-tu-ben-ngoai-e1615191158677.jpg",
        "Hospital Comples",
        "Find Hospital building stock images in HD and millions of other royalty-free stock photos, illustrations and vectors in the Shutterstock collection.",
        "2022-05-15 12:45:00",
      ),
      MedicalInstitute(
        "https://betongtrangtribm.com/wp-content/uploads/2021/03/d5daeb21ffa30cfd55b2.jpg",
        "Hospital Comples",
        "Find Hospital building stock images in HD and millions of other royalty-free stock photos, illustrations and vectors in the Shutterstock collection.",
        "2022-05-15 12:45:00",
      ),
    ];
    return Future.value(medicalInstitutes);
  }
}
