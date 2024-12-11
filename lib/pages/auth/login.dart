import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../routes/pages.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  final LoginController controller = Get.put(LoginController());
  late AnimationController _animController;
  late Animation<double> _logoScaleAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _formFadeAnimation;
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animController = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: this,
    );

    _logoScaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(2.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOutBack),
    ));

    _formFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional(0.2, -1.8),
            end: AlignmentDirectional(1.0, 0.6),
            colors: [
              CupertinoColors.systemBlue,
              CupertinoColors.white,
              CupertinoColors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 60),
                        width: 100,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ScaleTransition(
                              scale: _logoScaleAnimation,
                              child: SvgPicture.asset(
                                'assets/images/logo.svg',
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Positioned(
                              right: -40,
                              bottom: 0,
                              child: SlideTransition(
                                position: _textSlideAnimation,
                                child: const Text(
                                  'Astral',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeTransition(
                        opacity: _formFadeAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '欢迎使用',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '请输入您的邮箱地址',
                              style: TextStyle(
                                fontSize: 14,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            const SizedBox(height: 32),
                            CupertinoTextField(
                              focusNode: _emailFocusNode,
                              placeholder: '请输入邮箱',
                              padding: const EdgeInsets.all(12),
                              onChanged: (value) =>
                                  controller.email.value = value,
                              keyboardType: TextInputType.emailAddress,
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey6,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: Obx(() => CupertinoButton.filled(
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : () async {
                                            _emailFocusNode.unfocus();
                                            await controller
                                                .sendVerificationCode();
                                            if (controller.currentStep.value ==
                                                1) {
                                              Get.toNamed(
                                                  AppRoutes.verification);
                                            }
                                          },
                                    child: controller.isLoading.value
                                        ? const Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CupertinoActivityIndicator(
                                                color: CupertinoColors.white,
                                              ),
                                              SizedBox(width: 8),
                                              Text('获取验证码...'),
                                            ],
                                          )
                                        : const Text('获取验证码'),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadeTransition(
                opacity: _formFadeAnimation,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: const Column(
                    children: [
                      Text(
                        '登录即代表同意《用户协议》和《隐私政策》',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Copyright © 2024 All Rights Reserved',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
