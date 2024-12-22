import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../common/app_colors.dart';
import '../../../controllers/login_controller.dart';
import '../../../widgets/sheet_view.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF3F2F8),
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: '返回',
        middle: Text('隐私与安全'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 20),
            SheetView(
              title: '账号安全',
              children: [
                SheetViewItem(
                  icon: CupertinoIcons.lock,
                  title: '修改密码',
                  iconColor: AppColors.primaryColor,
                  onTap: () {},
                ),
                SheetViewItem(
                  icon: CupertinoIcons.device_phone_portrait,
                  title: '设备管理',
                  iconColor: CupertinoColors.activeGreen,
                  onTap: () {},
                ),
                SheetViewItem(
                  icon: CupertinoIcons.shield_lefthalf_fill,
                  title: '账号安全',
                  showDivider: false,
                  iconColor: CupertinoColors.systemBlue,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            SheetView(
              title: '隐私设置',
              children: [
                SheetViewItem(
                  icon: CupertinoIcons.eye_slash,
                  title: '隐私设置',
                  iconColor: CupertinoColors.systemIndigo,
                  onTap: () {},
                ),
                SheetViewItem(
                  icon: CupertinoIcons.hand_raised,
                  title: '黑名单管理',
                  iconColor: CupertinoColors.systemGrey,
                  showDivider: false,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: CupertinoColors.destructiveRed,
              onPressed: () {
                _showLogoutConfirmation(context, loginController);
              },
              child: const Text('退出登录'),
            )
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation(
      BuildContext context, LoginController controller) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('退出登录'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              controller.logout();
            },
            child: const Text('退出'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }
}
