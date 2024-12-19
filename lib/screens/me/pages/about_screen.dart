import 'package:astral/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../widgets/sheet_view.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _version = ''; // 版本号
  String _buildNumber = ''; // 构建号

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  /// 使用 Column + Expanded + Padding 实现版权信息置底
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: '返回',
        middle: Text('关于'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        CupertinoIcons.play_circle_fill,
                        size: 40,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '视频转实况',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black.withOpacity(0.9),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'v$_version ($_buildNumber)',
                      style: const TextStyle(
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SheetView(
                    children: [
                      SheetViewItem(
                        icon: CupertinoIcons.doc_text,
                        iconColor: CupertinoColors.systemGrey,
                        title: '用户协议',
                        onTap: () => {
                          debugPrint('用户协议'),
                          Get.toNamed(AppRoutes.agreement),
                        },
                      ),
                      SheetViewItem(
                        icon: CupertinoIcons.shield,
                        iconColor: CupertinoColors.systemGreen,
                        title: '隐私政策',
                        onTap: () => {
                          debugPrint('隐私政策'),
                          Get.toNamed(AppRoutes.privacy),
                        },
                      ),
                      SheetViewItem(
                        icon: CupertinoIcons.mail,
                        iconColor: const Color.fromARGB(255, 60, 154, 255),
                        title: '联系我们',
                        onTap: () => {
                          debugPrint('联系我们'),
                          Get.toNamed(AppRoutes.contact),
                        },
                      ),
                      SheetViewItem(
                        icon: CupertinoIcons.star,
                        iconColor: CupertinoColors.systemYellow,
                        title: '去评分',
                        onTap: () => {
                          debugPrint('去评分'),
                          Get.toNamed(AppRoutes.contact),
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  'Copyright © 2024 Astral. All Rights Reserved',
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
