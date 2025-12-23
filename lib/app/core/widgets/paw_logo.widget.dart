import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app.colors.dart';

enum PawLogoBorder { rounded, semiCircle, circle }

class PawLogoWidget extends StatelessWidget {
  const PawLogoWidget({
    super.key,
    this.sizeContainer = 56,
    this.sizeIcon = 32,
    this.border = PawLogoBorder.rounded,
    this.customRadius,
  });

  final double? sizeContainer;
  final double? sizeIcon;
  final PawLogoBorder border;
  final double? customRadius;

  double get _borderRadius {
    if (customRadius != null) return customRadius!.r;
    switch (border) {
      case PawLogoBorder.circle:
        final s = (sizeContainer ?? 56);
        return (s / 2).r;
      case PawLogoBorder.semiCircle:
        return 28.r;
      case PawLogoBorder.rounded:
        return 16.r;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeContainer?.w,
      height: sizeContainer?.w,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Center(
        child: Icon(Icons.pets, size: sizeIcon?.sp, color: AppColors.primary),
      ),
    );
  }
}
