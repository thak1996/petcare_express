import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app.colors.dart';
import '../theme/app.effects.dart';

class SocialLoginButtonWidget extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const SocialLoginButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: AppEffects.shadowSoft,
          border: Border.all(color: Colors.transparent),
        ),
        child: Center(child: icon),
      ),
    );
  }
}
