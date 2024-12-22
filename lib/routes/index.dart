/// 路由页面配置文件
/// 定义应用中所有页面的路由常量
/// part of 意思是导入pages.dart文件，并使用其中的常量
part of 'pages.dart';

abstract class AppRoutes {
  static const splash = '/splash';
  static const home = '/home';

  static const profile = '/me';
  static const login = '/login';
  static const verification = '/verification';

  static const about = '/me/about';
  static const agreement = '/me/about/agreement';
  static const privacy = '/me/about/privacy';
  static const contact = '/me/about/contact';

  static const security = '/me/security';

  static const message = '/message';
  static const test = '/test';
}
