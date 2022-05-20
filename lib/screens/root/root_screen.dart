import 'package:flutter_svg/flutter_svg.dart';
import 'package:wecheck/languages/language.dart';
import 'package:wecheck/routes/routes.dart';
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
      bottomNavigationBar: _bottomNavigationBar(),
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
        unselectedItemColor: AppColors.lightSlateGrey,
        selectedItemColor: AppColors.catalinaBlue,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: [
          _buildItem(
            AppIcons.icHomeSelected,
            AppIcons.icHomeUnSelected,
            L.current.home.tr,
          ),
          _buildItem(
            AppIcons.icTimelineSelected,
            AppIcons.icTimelineUnSelected,
            L.current.timeline.tr,
          ),
          _buildItem(
            AppIcons.icChatSelected,
            AppIcons.icChatUnSelected,
            L.current.chat.tr,
          ),
          _buildItem(
            AppIcons.icSettingSelected,
            AppIcons.icSettingUnSelected,
            L.current.setting.tr,
          ),
        ],
      );

  BottomNavigationBarItem _buildItem(
    String activeIcon,
    String icon,
    String name,
  ) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        width: 26.dp,
        height: 26.dp,
      ),
      activeIcon: SvgPicture.asset(
        activeIcon,
        width: 26.dp,
        height: 26.dp,
      ),
      label: name,
      backgroundColor: Colors.white,
    );
  }
}
