import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  final VoidCallback onPressed;

  const StyledButton({
    super.key,
    required this.backgroundColor,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(const Size(100, 40)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
