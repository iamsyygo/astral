import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/theme.dart';
import 'controllers/navigation_controller.dart';
import 'controllers/video_controller.dart';
import 'routes/pages.dart';
import 'services/storage/storage_service.dart';

void main() async {
  await initServices();
  runApp(const AstralApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => StorageService().init());
}

class AstralApp extends StatelessWidget {
  const AstralApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return GetCupertinoApp(
  //     title: '视频转实况',
  //     theme: AppTheme.light,
  //     localizationsDelegates: const [
  //       DefaultMaterialLocalizations.delegate,
  //       DefaultCupertinoLocalizations.delegate,
  //       DefaultWidgetsLocalizations.delegate,
  //     ],
  //     // 默认使用原生动画
  //     defaultTransition: Transition.native,
  //     initialRoute: AppPages.initial,
  //     getPages: AppPages.routes,
  //     // 初始化绑定
  //     initialBinding: BindingsBuilder(() {
  //       Get.put(NavigationController());
  //       Get.put(VideoController());
  //     }),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      title: '视频转实况',
      theme: AppTheme.light,
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      // 路由切换动画
      defaultTransition: Transition.rightToLeft,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      // 初始化绑定
      initialBinding: BindingsBuilder(() {
        Get.put(NavigationController());
        Get.put(VideoController());
      }),
    );
  }
}
