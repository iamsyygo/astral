import 'package:flutter/widgets.dart';

mixin LoginAnimationMixin<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  late final AnimationController animationController;
  late final Animation<double> logoScaleAnimation;
  late final Animation<Offset> brandNameSlideAnimation;
  late final Animation<double> contentFadeAnimation;

  void initializeAnimations() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: this,
    );

    logoScaleAnimation = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    brandNameSlideAnimation = Tween<Offset>(
      begin: const Offset(2.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOutBack),
    ));

    contentFadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
