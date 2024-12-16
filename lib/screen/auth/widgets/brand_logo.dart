import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/auth_constants.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({
    super.key,
    required this.logoScaleAnimation,
    required this.brandNameSlideAnimation,
  });

  final Animation<double> logoScaleAnimation;
  final Animation<Offset> brandNameSlideAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      width: 100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ScaleTransition(
            scale: logoScaleAnimation,
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              width: AuthConstants.logoSize,
              height: AuthConstants.logoSize,
            ),
          ),
          Positioned(
            right: -40,
            bottom: 0,
            child: SlideTransition(
              position: brandNameSlideAnimation,
              child: const Text(
                'Astral',
                style: TextStyle(
                  fontSize: AuthConstants.brandNameFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
