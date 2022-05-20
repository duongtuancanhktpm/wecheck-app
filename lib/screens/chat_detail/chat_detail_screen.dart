import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/model/message.dart';
import 'package:wecheck/screens/chat_detail/controller/chat_detail_controller.dart';
import 'package:wecheck/screens/chat_detail/widget/triangle_painter.dart';
import 'package:wecheck/theme/colors.dart';
import 'package:wecheck/theme/icons.dart';
import 'package:wecheck/theme/text_styles.dart';
import 'package:wecheck/utils/constants.dart';
import 'package:wecheck/widgets/app_bar.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? groupName = Get.arguments[Constant.argumentKey1] as String?;
    ChatDetailController controller = Get.put(ChatDetailController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.aliceBlue,
      appBar: AppBarWidget(
        title: groupName,
        didActionPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Column(
        children: [
          Obx(
            () {
              var messages = controller.messages.toList();
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildItemChat(messages[index]);
                },
                itemCount: messages.length,
              );
            },
          ),
          _buildInputChat(context)
        ],
      ),
    );
  }

  Widget _buildInputChat(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
        left: 18.w,
        right: 18.w,
        top: 8.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              AppIcons.icCamera,
            ),
          ),
          SizedBox(
            width: 18.w,
          ),
          Expanded(
            flex: 1,
            child: SvgPicture.asset(AppIcons.icGallery),
          ),
          SizedBox(
            width: 18.w,
          ),
          Expanded(
            flex: 8,
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: L.current.hintInput.tr,
                hintStyle: AppTextStyle.t14w400(AppColors.lightSlateGrey),
                contentPadding: const EdgeInsets.all(8),
                fillColor: AppColors.aliceBlue2,
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
          const Expanded(
            flex: 1,
            child: Icon(
              Icons.send,
              color: AppColors.catalinaBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemChat(UserMessage userMessage) {
    var type = userMessage.type;
    switch (type) {
      case "1":
        return _buildItemChatTypeReceiver(userMessage);
      case "2":
        return _buildItemChatTypeSend(userMessage);
      default:
        return const SizedBox();
    }
  }

  Widget _buildItemChatTypeReceiver(UserMessage userMessage) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(userMessage.user?.avatarUrl),
              _buildTriangleWidget(270),
              Flexible(
                flex: 7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildChatBody(userMessage.body),
                    _buildChatTimestamp(userMessage.timestamp),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }

  Widget _buildItemChatTypeSend(UserMessage userMessage) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildChatTimestamp(userMessage.timestamp),
                  _buildChatBody(userMessage.body)
                ],
              ),
            ),
            _buildTriangleWidget(0)
          ],
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }

  Widget _buildChatTimestamp(String? timestamp) {
    var dateTimeDisplay = "NaN";
    if (timestamp != null) {
      var dateTime = DateFormat(Constant.fullDataFormat).parse(
        timestamp,
      );
      dateTimeDisplay = DateFormat.Hm().format(dateTime);
    }
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            dateTimeDisplay,
            style: AppTextStyle.t14w500(AppColors.lightSlateGrey),
          ),
        ),
      ),
    );
  }

  Widget _buildChatBody(String? body) {
    return Flexible(
      flex: 8,
      child: Container(
        constraints: BoxConstraints(maxWidth: 250.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.white,
        ),
        child: Text(
          body ?? "",
          style: AppTextStyle.t14w500(AppColors.catalinaBlue),
        ),
      ),
    );
  }

  Widget _buildTriangleWidget(int rotate) {
    return RotatedBox(
      quarterTurns: rotate,
      child: SizedBox(
        width: 30.w,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: CustomPaint(
            painter: TrianglePainter(),
            child: const Text(""),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(String? imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        imageUrl!,
        width: 52.w,
        height: 52.h,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return Container(
            color: AppColors.lightSlateGrey,
          );
        },
      ),
    );
  }
}
