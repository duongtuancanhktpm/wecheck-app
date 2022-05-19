import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/screens/chat/controller/chat_controller.dart';
import 'package:wecheck/screens/group_chat/group_chat_screen.dart';
import 'package:wecheck/screens/reverse/reverse_screen.dart';
import 'package:wecheck/theme/theme.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.aliceBlue,
      appBar: _buildAppBarSearch(),
      body: _buildTabBar(),
    );
  }

  Widget _buildItemSegmented(String title, int tabCount) {
    return InkWell(
      onTap: () {
        controller.changeSelectedSegment(tabCount);
      },
      child: SizedBox(
        height: 36.h,
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.t16w700(AppColors.catalinaBlue),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBarSearch() {
    return AppBar(
      toolbarHeight: 160.h,
      backgroundColor: AppColors.aliceBlue,
      titleSpacing: 12.w,
      title: Padding(
        padding: EdgeInsets.only(
          left: 12.w,
          right: 15.w,
        ),
        child: Column(
          children: [
            _buildSearchTabBar(),
            SizedBox(
              height: 30.h,
            ),
            _buildSegmentTabBar()
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTabBar() {
    return SizedBox(
      height: 42.h,
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: TextField(
              decoration: InputDecoration(
                hintText: L.current.search.tr,
                hintStyle: AppTextStyle.t14w400(AppColors.lightSlateGrey),
                contentPadding: const EdgeInsets.all(0),
                fillColor: AppColors.hawkesBlue,
                prefixIcon: Icon(
                  Icons.search,
                  size: 25.w,
                  color: AppColors.lightSlateGrey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 0.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 0.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SvgPicture.asset(
              AppIcons.icEdit,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSegmentTabBar() {
    return Obx(
      () {
        int tabCount = controller.selectedSegment.value;
        return SizedBox(
          width: double.infinity,
          child: CupertinoSlidingSegmentedControl<int>(
            groupValue: tabCount,
            children: <int, Widget>{
              0: _buildItemSegmented(L.current.chat.tr, 0),
              1: _buildItemSegmented(L.current.reserve.tr, 1),
            },
            onValueChanged: (tab) {
              controller.changeSelectedSegment(tab);
            },
          ),
        );
      },
    );
  }

  Widget _buildTabBar() {
    return Obx(
      () {
        int tabCount = controller.selectedSegment.value;
        return tabCount == 0 ? const GroupChatScreen() : ReverseScreen();
      },
    );
  }
}
