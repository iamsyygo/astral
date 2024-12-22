import 'package:astral/common/app_colors.dart';
import 'package:flutter/cupertino.dart';

enum AuthButtonState {
  normal,
  loading,
  countdown;

  bool get isLoading => this == AuthButtonState.loading;
  bool get isCountdown => this == AuthButtonState.countdown;
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.countDown,
  });

  final VoidCallback? onPressed;
  final bool isLoading;
  final int countDown;

  AuthButtonState get _buttonState {
    if (isLoading) return AuthButtonState.loading;
    if (countDown < 60) return AuthButtonState.countdown;
    return AuthButtonState.normal;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton.filled(
        onPressed: _buttonState.isLoading ? null : onPressed,
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    switch (_buttonState) {
      case AuthButtonState.loading:
        return const _LoadingContent();
      case AuthButtonState.countdown:
        return _CountdownContent(seconds: countDown);
      case AuthButtonState.normal:
        return const Text('获取验证码');
    }
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoActivityIndicator(color: CupertinoColors.white),
        SizedBox(width: 8),
        Text('获取验证码...'),
      ],
    );
  }
}

class _CountdownContent extends StatelessWidget {
  const _CountdownContent({required this.seconds});

  final int seconds;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$seconds 秒后可重新发送',
      style: const TextStyle(color: CupertinoColors.white),
    );
  }
}
