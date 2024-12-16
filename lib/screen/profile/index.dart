import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../routes/pages.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey5,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(
                      CupertinoIcons.person_fill,
                      size: 40,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '用户名',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'ID: 12345678',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CupertinoListSection(
              children: [
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('设置'),
                  trailing: const Icon(CupertinoIcons.right_chevron),
                  onTap: () {},
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.info),
                  title: const Text('关于'),
                  trailing: const Icon(CupertinoIcons.right_chevron),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoButton(
                color: CupertinoColors.destructiveRed,
                child: const Text('退出登录'),
                onPressed: () => Get.offAllNamed(AppRoutes.login),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
