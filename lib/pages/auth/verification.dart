import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../controllers/login_controller.dart';
import 'package:flutter/services.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView>
    with SingleTickerProviderStateMixin {
  final LoginController controller = Get.find();
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _resendTimer;
  final _remainingTime = 60.obs;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startResendTimer();
    _setupKeyboardListener();
  }

  void _setupAnimations() {
    _animController = AnimationController(
      duration: const Duration(milliseconds: 400),
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

  void _startResendTimer() {
    _remainingTime.value = 60;
    _resendTimer?.cancel();
    // 使用Timer.periodic来实现每隔1秒减少1秒，Timer.periodic是Flutter中用于实现定时任务的类
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.value > 0) {
        _remainingTime.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void _setupKeyboardListener() {
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (!_focusNodes[i].hasFocus && _controllers[i].text.isEmpty && i > 0) {
          // 当失去焦点且当前输入框为空时，将焦点移到前一个输入框
          _focusNodes[i - 1].requestFocus();
        }
      });
    }

    RawKeyboard.instance.addListener(_handleKeyPress);
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        // 找到当前焦点所在的输入框
        final currentIndex = _focusNodes.indexWhere((node) => node.hasFocus);
        if (currentIndex != -1) {
          if (_controllers[currentIndex].text.isEmpty && currentIndex > 0) {
            // 如果当前输入框为空且不是第一个输入框，移动焦点到前一个输入框
            _focusNodes[currentIndex - 1].requestFocus();
            _controllers[currentIndex - 1].clear();
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    _resendTimer?.cancel();
    RawKeyboard.instance.removeListener(_handleKeyPress);
    super.dispose();
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
                  '验证码已发送至 ${controller.email}',
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
                  children: List.generate(6, (index) {
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
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: const TextStyle(fontSize: 20),
                          decoration: const BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                          ),
                          padding: const EdgeInsets.only(bottom: 2),
                          onEditingComplete: () {
                            if (index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          },
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (index < 5) {
                                _focusNodes[index + 1].requestFocus();
                              } else {
                                FocusScope.of(context).unfocus();
                              }
                            } else if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                            String fullCode =
                                _controllers.map((c) => c.text).join();
                            controller.onCodeChanged(fullCode);
                          },
                          onTap: () {
                            _controllers[index].selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: _controllers[index].text.length),
                            );
                          },
                          onSubmitted: (_) {
                            if (index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textInputAction: index == 5
                              ? TextInputAction.done
                              : TextInputAction.next,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Obx(() => _remainingTime.value > 0
                      ? Text('${_remainingTime.value}秒后可重新发送',
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                          ))
                      : CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Text('重新发送验证码'),
                          onPressed: () {
                            controller.sendVerificationCode();
                            _startResendTimer();
                          },
                        )),
                ),
              ),
              const Spacer(),
              Obx(() => controller.isLoading.value
                  ? const Center(child: CupertinoActivityIndicator())
                  : const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
