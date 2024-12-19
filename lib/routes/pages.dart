import 'package:astral/screens/me/pages/about_screen.dart';
import 'package:astral/screens/splash_screen.dart';
import 'package:get/get.dart';
import '../screens/auth/login.dart';
import '../screens/auth/verification.dart';
import '../screens/main/index.dart';
import '../screens/me/pages/agreement_screen.dart';
import '../screens/me/pages/privacy_screen.dart';
import '../screens/me/pages/contact_screen.dart';

// 导入路由配置文件，包含所有路由常量定义
part 'index.dart';

class AppPages {
  static const initial = AppRoutes.login;
  // static const initial = AppRoutes.test;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.verification,
      page: () => const VerificationScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const MainView(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutScreen(),
    ),
    GetPage(
      name: AppRoutes.agreement,
      page: () => const AgreementScreen(),
    ),
    GetPage(
      name: AppRoutes.privacy,
      page: () => const PrivacyScreen(),
    ),
    GetPage(
      name: AppRoutes.contact,
      page: () => const ContactScreen(),
    ),
  ];
}
