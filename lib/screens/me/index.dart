import 'package:astral/controllers/login_controller.dart';
import 'package:astral/services/storage/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/pages.dart';
import '../../widgets/sheet_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final LoginController _loginController = Get.put(LoginController());
  final StorageService _storage = Get.find<StorageService>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF3F2F8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: ListView(
            children: [
              const Text(
                '个人信息',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
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
                      child: Obx(
                        () => _storage.user.value?.avatar != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.network(
                                  _storage.user.value?.avatar ?? '',
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                CupertinoIcons.person_fill,
                                size: 40,
                                color: CupertinoColors.systemGrey,
                              ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _storage.user.value?.username ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _storage.user.value?.account ?? '',
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SheetView(
                children: [
                  SheetViewItem(
                    icon: CupertinoIcons.person_circle,
                    title: '个人信息设置',
                    iconColor: CupertinoColors.activeBlue,
                    onTap: () => {
                      debugPrint('个人信息设置'),
                    },
                  ),
                  SheetViewItem(
                    icon: CupertinoIcons.lock_shield,
                    iconColor: CupertinoColors.activeGreen,
                    title: '隐私与安全',
                    onTap: () => {
                      debugPrint('隐私与安全'),
                    },
                  ),
                  SheetViewItem(
                    icon: CupertinoIcons.bell,
                    title: '通知与偏好',
                    iconColor: CupertinoColors.systemRed,
                    onTap: () => {
                      debugPrint('通知与偏好'),
                    },
                  ),
                  SheetViewItem(
                    icon: CupertinoIcons.doc_text,
                    title: '数据管理',
                    iconColor: CupertinoColors.activeOrange,
                    onTap: () => {
                      debugPrint('数据管理'),
                    },
                  ),
                  SheetViewItem(
                    icon: CupertinoIcons.question_circle,
                    title: '反馈与帮助',
                    iconColor: CupertinoColors.systemBrown,
                    onTap: () => {
                      debugPrint('反馈与帮助'),
                    },
                  ),
                  SheetViewItem(
                    icon: CupertinoIcons.settings,
                    title: '其他功能',
                    iconColor: CupertinoColors.systemGrey,
                    onTap: () => {
                      debugPrint('其他功能'),
                    },
                  ),
                  SheetViewItem(
                    icon: CupertinoIcons.info_circle,
                    title: '关于 Astral',
                    showDivider: false,
                    iconColor: CupertinoColors.activeOrange,
                    onTap: () => {
                      debugPrint('关于 Astral'),
                      Get.toNamed(AppRoutes.about),
                    },
                  ),
                ],
              ),
              // const SizedBox(height: 20),
              // CupertinoButton(
              //   color: CupertinoColors.destructiveRed,
              //   child: const Text('退出登录'),
              //   onPressed: () => _loginController.logout(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
