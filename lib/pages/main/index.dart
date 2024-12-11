import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../home/index.dart';
import '../profile/index.dart';
import '../../controllers/navigation_controller.dart';

class MainView extends GetView<NavigationController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Icon(CupertinoIcons.house_fill),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Icon(CupertinoIcons.person),
                ),
                label: '',
              ),
            ],
            iconSize: 24,
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return const HomeView();
              case 1:
                return const ProfileView();
              default:
                return const HomeView();
            }
          },
        ));
  }
}
