import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/group_chat.dart';
import 'package:wecheck/model/medical_institute.dart';
import 'package:wecheck/model/partner.dart';
import 'package:wecheck/routes/routes.dart';
import 'package:wecheck/screens/group_chat/controller/group_chat_controller.dart';
import 'package:wecheck/theme/theme.dart';
import 'package:wecheck/utils/constants.dart';

class GroupChatScreen extends StatelessWidget {
  const GroupChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GroupChatController());
    return Scaffold(
      backgroundColor: AppColors.aliceBlue,
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return _buildItemSeparator(L.current.groupChat.tr);
            case 1:
              return Obx(
                () {
                  var groupChats = controller.groupUsers.toList();
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: AppColors.catalinaBlue,
                      height: 0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _buildItemGroupChat(
                        groupChats[index],
                      );
                    },
                    itemCount: groupChats.length,
                  );
                },
              );
            case 2:
              return _buildItemSeparator(L.current.medicalInstitute.tr);
            case 3:
              return Obx(() {
                var medicalsInstitutes = controller.medicalInstitutes.toList();
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: AppColors.catalinaBlue,
                    height: 0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _buildItemMedicalInstitute(
                      medicalsInstitutes[index],
                    );
                  },
                  itemCount: medicalsInstitutes.length,
                );
              });
            case 4:
              return _buildItemSeparator(L.current.partner.tr);
            case 5:
              return Obx(() {
                var partners = controller.partners.toList();
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: AppColors.catalinaBlue,
                    height: 0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _buildItemPartners(
                      partners[index],
                    );
                  },
                  itemCount: partners.length,
                );
              });
            case 6:
              return _buildItemSeparator("");
            default:
              return const SizedBox();
          }
        },
        itemCount: 7,
      ),
    );
  }

  Widget _buildItemPartners(Partner partner) {
    return Container(
      color: Colors.white,
      height: 102.dp,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 20.dp,
            child: _buildAvatar(partner.partnerUrl),
          ),
          Positioned(
            left: 102.dp,
            top: 23.dp,
            right: 80.dp,
            child: Text(
              partner.name ?? "",
              maxLines: 1,
              style: AppTextStyle.t18w700(AppColors.catalinaBlue),
            ),
          ),
          Positioned(
            left: 102.dp,
            top: 50.dp,
            right: 80.dp,
            child: Text(
              partner.description ?? "",
              maxLines: 2,
              style: AppTextStyle.t14w500(AppColors.lightSlateGrey),
            ),
          ),
          _buildDateTimeBody(partner.createAt),
        ],
      ),
    );
  }

  Widget _buildItemMedicalInstitute(MedicalInstitute medicalInstitute) {
    return Container(
      color: Colors.white,
      height: 102.dp,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 20.dp,
            child: _buildAvatar(medicalInstitute.imageUrl),
          ),
          Positioned(
            left: 102.dp,
            top: 23.dp,
            right: 80.dp,
            child: Text(
              medicalInstitute.name ?? "",
              maxLines: 1,
              style: AppTextStyle.t18w700(AppColors.catalinaBlue),
            ),
          ),
          Positioned(
            left: 102.dp,
            top: 50.dp,
            right: 80.dp,
            child: Text(
              medicalInstitute.description ?? "",
              maxLines: 2,
              style: AppTextStyle.t14w500(AppColors.lightSlateGrey),
            ),
          ),
          _buildDateTimeBody(medicalInstitute.createAt),
        ],
      ),
    );
  }

  Widget _buildItemGroupChat(GroupUser user) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.chatDetail,
            arguments: {Constant.argumentKey1: user.nameGroup});
      },
      child: Container(
        color: Colors.white,
        height: 102.dp,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              left: 40.dp,
              child: _buildAvatar(user.users?[0].avatarUrl),
            ),
            Positioned(
              left: 20.dp,
              child: _buildAvatar(user.users?[1].avatarUrl),
            ),
            Positioned(
              left: 132.dp,
              top: 23.dp,
              right: 80.dp,
              child: Text(
                user.nameGroup ?? "",
                maxLines: 1,
                style: AppTextStyle.t18w700(AppColors.catalinaBlue),
              ),
            ),
            Positioned(
              left: 132.dp,
              top: 50.dp,
              right: 80.dp,
              child: Text(
                user.description ?? "",
                maxLines: 2,
                style: AppTextStyle.t14w500(AppColors.lightSlateGrey),
              ),
            ),
            _buildDateTimeBody(user.createAt),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String? imageUrl) {
    if (imageUrl == null) {
      return Container(
        width: 62.dp,
        height: 62.dp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.lightSlateGrey),
        child: const Text(""),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        imageUrl,
        width: 62.dp,
        height: 62.dp,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return Container(
            color: Colors.red,
          );
        },
      ),
    );
  }

  Widget _buildDateTimeBody(String? createAt) {
    String dateTimeDisplay = "NaN";
    if (createAt != null) {
      var dateTime = DateFormat(Constant.fullDataFormat).parse(
        createAt,
      );
      dateTimeDisplay = DateFormat.Hm().format(dateTime);
    }
    return Positioned(
      right: 22.dp,
      top: 23.dp,
      child: Text(
        dateTimeDisplay,
        style: AppTextStyle.t14w500(AppColors.lightSlateGrey),
      ),
    );
  }

  Widget _buildItemSeparator(String name) {
    return Container(
      padding: EdgeInsets.only(left: 22.dp),
      height: 57.dp,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          name,
          style: AppTextStyle.t16w800(AppColors.catalinaBlue),
        ),
      ),
    );
  }
}
