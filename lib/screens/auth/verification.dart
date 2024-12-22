import 'package:astral/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../controllers/login_controller.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  static const int _codeLength = 6;
  static const Duration _animDuration = Duration(milliseconds: 400);

  final LoginController _authController = Get.find<LoginController>();
  final _pinController = TextEditingController();
  final _pinFocusNode = FocusNode();

  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animController = AnimationController(
      duration: _animDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    ));

    _animController.forward();
  }

  Widget _buildResendButton() {
    return Obx(() {
      if (_authController.loginState.countDown > 0) {
        return Text(
          '${_authController.loginState.countDown}秒后可重新发送',
          style: const TextStyle(color: CupertinoColors.systemGrey),
        );
      }
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: _authController.sendEmailCode,
        child: const Text('重新发送验证码'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 55,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: CupertinoColors.activeBlue),
      ),
    );

    return Material(
        child: CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: '返回',
        middle: Text('验证码'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  '请输入验证码',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.black.withOpacity(0.8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  '验证码已发送至 ${_authController.loginState.email}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Pinput(
                  length: _codeLength,
                  controller: _pinController,
                  focusNode: _pinFocusNode,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: defaultPinTheme,
                  onCompleted: (pin) => _authController.updateCode(pin),
                  onChanged: _authController.updateCode,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  keyboardType: TextInputType.number,
                  // separator: const SizedBox(width: 8),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildResendButton(),
                ),
              ),
              const Spacer(),
              Obx(() => _authController.state.isLoading
                  ? const Center(child: CupertinoActivityIndicator())
                  : const SizedBox()),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  child: const Text('完成'),
                  onPressed: () => _authController.handleLogin(),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    _animController.dispose();
    super.dispose();
  }
}
