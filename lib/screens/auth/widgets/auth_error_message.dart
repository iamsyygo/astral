import 'package:flutter/cupertino.dart';

class AuthErrorMessage extends StatelessWidget {
  const AuthErrorMessage({
    super.key,
    required this.message,
    this.onDismiss,
  });

  final String message;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: CupertinoColors.systemRed.withOpacity(0.1),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: CupertinoColors.systemRed,
                fontSize: 14,
              ),
            ),
          ),
          if (onDismiss != null)
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: onDismiss,
              child: const Icon(
                CupertinoIcons.clear_circled,
                color: CupertinoColors.systemRed,
              ),
            ),
        ],
      ),
    );
  }
}
