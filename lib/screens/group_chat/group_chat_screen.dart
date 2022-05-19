import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/group_chat.dart';
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
    var dateTime = DateFormat(Constant.fullDataFormat).parse(
      partner.createAt,
    );
    var dateTimeDisplay = DateFormat.Hm().format(dateTime);
    return Container(
      color: Colors.white,
      height: 102.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 20.w,
            child: _buildAvatar(partner.partnerUrl),
          ),
          Positioned(
            left: 102.w,
            top: 23.h,
            right: 80.w,
            child: Text(
              partner.name,
              maxLines: 1,
              style: AppTextStyle.t18w700(AppColors.catalinaBlue),
            ),
          ),
          Positioned(
            left: 102.w,
            top: 50.h,
            right: 80.w,
            child: Text(
              partner.description,
              maxLines: 2,
              style: AppTextStyle.t14w500(AppColors.lightSlateGrey),
            ),
          ),
          Positioned(
            right: 22.w,
            top: 23.h,
            child: Text(
              dateTimeDisplay,
              style: AppTextStyle.t14w500(AppColors.lightSlateGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemMedicalInstitute(MedicalInstitute medicalInstitute) {
    var dateTime = DateFormat(Constant.fullDataFormat).parse(
      medicalInstitute.createAt,
    );
    var dateTimeDisplay = DateFormat.Hm().format(dateTime);
    return Container(
      color: Colors.white,
      height: 102.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 20.w,
            child: _buildAvatar(medicalInstitute.imageUrl),
          ),
          Positioned(
            left: 102.w,
            top: 23.h,
            right: 80.w,
            child: Text(
              medicalInstitute.name,
              maxLines: 1,
              style: AppTextStyle.t18w700(AppColors.catalinaBlue),
            ),
          ),
          Positioned(
            left: 102.w,
            top: 50.h,
            right: 80.w,
            child: Text(
              medicalInstitute.description,
              maxLines: 2,
              style: AppTextStyle.t14w500(AppColors.lightSlateGrey),
            ),
          ),
          Positioned(
            right: 22.w,
            top: 23.h,
            child: Text(
              dateTimeDisplay,
              style: AppTextStyle.t14w500(AppColors.lightSlateGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemGroupChat(GroupUser user) {
    var dateTime = DateFormat(Constant.fullDataFormat).parse(user.createAt);
    var dateTimeDisplay = DateFormat.Hm().format(dateTime);
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.chatDetail,
            arguments: {Constant.argumentKey1: user.nameGroup});
      },
      child: Container(
        color: Colors.white,
        height: 102.h,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              left: 40.w,
              child: _buildAvatar(user.users[0].avatarUrl),
            ),
            Positioned(
              left: 20.w,
              child: _buildAvatar(user.users[1].avatarUrl),
            ),
            Positioned(
              left: 132.w,
              top: 23.h,
              right: 80.w,
              child: Text(
                user.nameGroup,
                maxLines: 1,
                style: AppTextStyle.t18w700(AppColors.catalinaBlue),
              ),
            ),
            Positioned(
              left: 132.w,
              top: 50.h,
              right: 80.w,
              child: Text(
                user.description,
                maxLines: 2,
                style: AppTextStyle.t14w500(AppColors.lightSlateGrey),
              ),
            ),
            Positioned(
              right: 22.w,
              top: 23.h,
              child: Text(
                dateTimeDisplay,
                style: AppTextStyle.t14w500(AppColors.lightSlateGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        imageUrl,
        width: 62.w,
        height: 62.h,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildItemSeparator(String name) {
    return Container(
      padding: EdgeInsets.only(left: 22.w),
      height: 57.h,
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
