import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  static const int _codeLength = 6;
  // 动画持续时间
  static const Duration _animDuration = Duration(milliseconds: 400);

  // 登录控制器
  final LoginController _authController = Get.find<LoginController>();
  // 焦点节点列表
  final List<FocusNode> _focusNodes =
      List.generate(_codeLength, (index) => FocusNode());
  // 输入控制器列表
  final List<TextEditingController> _codeControllers =
      List.generate(_codeLength, (index) => TextEditingController());

  // 动画相关控制器和动画对象
  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setupFocusListeners();
    _setupKeyboardListener();
  }

  // 初始化动画
  void _initializeAnimations() {
    _animController = AnimationController(
      duration: _animDuration,
      vsync: this,
    );

    // 缩放动画
    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    // 淡入动画
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    ));

    _animController.forward();
  }

  // 设置焦点监听器
  void _setupFocusListeners() {
    for (int i = 0; i < _codeLength; i++) {
      _focusNodes[i].addListener(() => _handleFocusChange(i));
    }
  }

  // 处理焦点变化
  void _handleFocusChange(int index) {
    if (!_focusNodes[index].hasFocus &&
        _codeControllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  // 设置键盘监听器
  void _setupKeyboardListener() {
    RawKeyboard.instance.addListener(_handleKeyPress);
  }

  // 处理键盘按键事件
  void _handleKeyPress(RawKeyEvent event) {
    if (event is! RawKeyDownEvent) return;
    if (event.logicalKey != LogicalKeyboardKey.backspace) return;

    final currentIndex = _focusNodes.indexWhere((node) => node.hasFocus);
    if (currentIndex == -1) return;

    if (_codeControllers[currentIndex].text.isEmpty && currentIndex > 0) {
      _focusNodes[currentIndex - 1].requestFocus();
      _codeControllers[currentIndex - 1].clear();
    }
  }

  // 处理验证码输入
  void _handleCodeInput(int index, String value) {
    if (value.isNotEmpty) {
      if (index < _codeLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        FocusScope.of(context).unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final fullCode = _codeControllers.map((c) => c.text).join();
    _authController.onCodeChanged(fullCode);
  }

  @override
  void dispose() {
    _animController.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    RawKeyboard.instance.removeListener(_handleKeyPress);
    super.dispose();
  }

  // 构建验证码输入框
  Widget _buildCodeInputField(int index) {
    return Container(
      width: 45,
      height: 55,
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
      child: Center(
        child: CupertinoTextField(
          controller: _codeControllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: const TextStyle(fontSize: 20),
          decoration: const BoxDecoration(
            color: CupertinoColors.systemGrey6,
          ),
          padding: const EdgeInsets.only(bottom: 2),
          onEditingComplete: () => _handleEditingComplete(index),
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          onChanged: (value) => _handleCodeInput(index, value),
          onTap: () => _selectAllText(index),
          onSubmitted: (_) => _handleSubmitted(index),
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          textInputAction: index == _codeLength - 1
              ? TextInputAction.done
              : TextInputAction.next,
        ),
      ),
    );
  }

  // 处理编辑完成事件
  void _handleEditingComplete(int index) {
    if (index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  // 选中输入框中的所有文本
  void _selectAllText(int index) {
    _codeControllers[index].selection = TextSelection(
      baseOffset: 0,
      extentOffset: _codeControllers[index].text.length,
    );
  }

  // 处理提交事件
  void _handleSubmitted(int index) {
    if (index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  // 构建重新发送按钮
  Widget _buildResendButton() {
    return Obx(() {
      if (_authController.countDown.value > 0) {
        return Text(
          '${_authController.countDown.value}秒后可重新发送',
          style: const TextStyle(color: CupertinoColors.systemGrey),
        );
      }
      return CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Text('重新发送验证码'),
        onPressed: _authController.sendEmailCode,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
                  '验证码已发送至 ${_authController.email}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ScaleTransition(
                scale: _scaleAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    _codeLength,
                    (index) => _buildCodeInputField(index),
                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
