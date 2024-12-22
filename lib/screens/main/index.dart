import 'package:astral/common/app_colors.dart';
import 'package:astral/constants/navigation.icon.dart';
import 'package:astral/controllers/navigation_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:astral/screens/home/index.dart';
import 'package:astral/screens/me/index.dart';
import 'package:astral/screens/message/index.dart';

class MainView extends GetView<NavigationController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CupertinoTabScaffold(
          tabBar: _buildTabBar(),
          tabBuilder: _buildTabView,
        ));
  }

  CupertinoTabBar _buildTabBar() {
    return CupertinoTabBar(
      currentIndex: controller.currentIndex.value,
      onTap: controller.changePage,
      items: [
        _buildNavItem(
          activeIcon: NavigationIcon.homeActive,
          defaultIcon: NavigationIcon.homeDefault,
        ),
        _buildNavItem(
          activeIcon: NavigationIcon.messageActive,
          defaultIcon: NavigationIcon.messageDefault,
        ),
        _buildNavItem(
          activeIcon: NavigationIcon.meActive,
          defaultIcon: NavigationIcon.meDefault,
        ),
      ],
      iconSize: 24,
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String activeIcon,
    required String defaultIcon,
  }) {
    return BottomNavigationBarItem(
      activeIcon: _buildNavIcon(
        icon: activeIcon,
        color: AppColors.primaryColor,
      ),
      icon: _buildNavIcon(
        icon: defaultIcon,
        color: AppColors.textColor2,
      ),
      label: '',
    );
  }

  Widget _buildNavIcon({
    required String icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: SvgPicture.string(
        icon,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildTabView(BuildContext context, int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const MessageView(); // 消息页面
      case 2:
        return const ProfileView();
      default:
        return const HomeView();
    }
  }
}
