import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/routes/routes.dart';
import 'package:wecheck/screens/timeline/binding/timeline_binding.dart';
import 'package:wecheck/screens/timeline/timeline_screen.dart';
import 'package:wecheck/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final GlobalKey<NavigatorState> homeNavigator = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> timeLineNavigator = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> chatNavigator = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> settingNavigator = GlobalKey<NavigatorState>();

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  var pageController = PageController();
  var selectedIndex = 0;

  static Future<bool> _onWillPopScope(
    GlobalKey<NavigatorState> globalKey,
  ) async {
    return !await globalKey.currentState!.maybePop();
  }

  static Widget _buildNavigatorWidget(
    GlobalKey<NavigatorState> globalKey,
    String initRoute,
  ) {
    return WillPopScope(
      onWillPop: () => _onWillPopScope(globalKey),
      child: Navigator(
        key: globalKey,
        initialRoute: initRoute,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }

  final pages = [
    _buildNavigatorWidget(homeNavigator, RouteName.home),
    _buildNavigatorWidget(timeLineNavigator, RouteName.timeline),
    _buildNavigatorWidget(chatNavigator, RouteName.chat),
    _buildNavigatorWidget(settingNavigator, RouteName.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 84.h,
        child: _bottomNavigationBar(),
      ),
      body: PageView(
        controller: pageController,
        children: pages,
      ),
    );
  }

  Widget _bottomNavigationBar() => BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            pageController.jumpToPage(index);
          });
        },
        elevation: 30,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: AppColors.labelColor,
        selectedItemColor: AppColors.labelSelectedColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.icHomeUnSelected,
              width: 26.w,
              height: 26.w,
            ),
            activeIcon: SvgPicture.asset(
              AppIcons.icHomeSelected,
              width: 26.w,
              height: 26.w,
            ),
            label: L.current.home.tr,
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.icTimelineUnSelected,
              width: 26.w,
              height: 26.w,
            ),
            activeIcon: SvgPicture.asset(
              AppIcons.icTimelineSelected,
              width: 26.w,
              height: 26.w,
            ),
            label: L.current.timeline.tr,
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.icChatUnSelected,
              width: 26.w,
              height: 26.w,
            ),
            activeIcon: SvgPicture.asset(
              AppIcons.icChatSelected,
              width: 26.w,
              height: 26.w,
            ),
            label: L.current.chat.tr,
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.icSettingUnSelected,
              width: 26.w,
              height: 26.w,
            ),
            activeIcon: SvgPicture.asset(
              AppIcons.icSettingSelected,
              width: 26.w,
              height: 26.w,
            ),
            label: L.current.setting.tr,
            backgroundColor: Colors.white,
          ),
        ],
      );
}
