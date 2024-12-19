import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../routes/pages.dart';
import 'constants/auth_constants.dart';
import 'mixins/login_animation_mixin.dart';
import 'widgets/auth_button.dart';
import 'widgets/brand_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin, LoginAnimationMixin<LoginScreen> {
  // 登录控制器
  final LoginController controller = Get.put(LoginController());
  // 邮箱焦点节点
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    initializeAnimations();
    animationController.forward();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleEmailSubmit() async {
    _emailFocusNode.unfocus();
    await controller.sendEmailCode();
    if (controller.isValidEmail == 1) {
      Get.toNamed(AppRoutes.verification);
    }
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '欢迎使用',
          style: TextStyle(
            fontSize: AuthConstants.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '请输入邮箱地址进行登录或注册',
          style: TextStyle(
            fontSize: AuthConstants.subtitleFontSize,
            color: CupertinoColors.systemGrey,
          ),
        ),
        const SizedBox(height: 32),
        _buildEmailInput(),
        const SizedBox(height: 24),
        Obx(() => AuthButton(
              onPressed: controller.canSendCode ? _handleEmailSubmit : null,
              isLoading: controller.state.isLoading,
              countDown: controller.loginState.countDown,
            )),
      ],
    );
  }

  Widget _buildEmailInput() {
    return CupertinoTextField(
      focusNode: _emailFocusNode,
      placeholder: '您的邮箱地址',
      padding: const EdgeInsets.all(AuthConstants.inputPadding),
      onChanged: (value) => controller.updateEmail(value),
      keyboardType: TextInputType.emailAddress,
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _renderFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: const Column(
        children: [
          Text(
            '登录或注册即表示您同意《用户协议》和《隐私政策》',
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: AuthConstants.footerFontSize,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Copyright © 2024 Astral. All Rights Reserved',
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: AuthConstants.footerFontSize,
            ),
          ),
        ],
      ),
    );
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
                  padding: const EdgeInsets.all(AuthConstants.formPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BrandLogo(
                        logoScaleAnimation: logoScaleAnimation,
                        brandNameSlideAnimation: brandNameSlideAnimation,
                      ),
                      FadeTransition(
                        opacity: contentFadeAnimation,
                        child: _buildLoginForm(),
                      ),
                    ],
                  ),
                ),
              ),
              FadeTransition(
                opacity: contentFadeAnimation,
                child: _renderFooter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
