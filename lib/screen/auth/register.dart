import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../routes/pages.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('注册'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CupertinoTextField(
                placeholder: '用户名',
                padding: EdgeInsets.all(12),
              ),
              const SizedBox(height: 16),
              const CupertinoTextField(
                placeholder: '密码',
                obscureText: true,
                padding: EdgeInsets.all(12),
              ),
              const SizedBox(height: 16),
              const CupertinoTextField(
                placeholder: '确认密码',
                obscureText: true,
                padding: EdgeInsets.all(12),
              ),
              const SizedBox(height: 32),
              CupertinoButton.filled(
                child: const Text('注册'),
                onPressed: () => Get.offAllNamed(AppRoutes.home),
              ),
              const SizedBox(height: 16),
              CupertinoButton(
                child: const Text('已有账号? 立即登录'),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
