import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppEffects {
  AppEffects._();

  static List<BoxShadow> get shadowSoft => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 20,
      spreadRadius: -2,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.02),
      blurRadius: 1,
      spreadRadius: 0,
      offset: const Offset(0, 0),
    ),
  ];

  static LinearGradient get primaryGradient => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF13ECEC), Color(0xFF00D4FF)],
  );

  static Widget get buildBackgroundDecoration => Stack(
    children: [
      Positioned(
        top: -100.h,
        left: -80.w,
        child: Container(
          width: 300.w,
          height: 300.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF13ECEC).withValues(alpha: 0.12),
          ),
        ),
      ),
      Positioned(
        bottom: -100.h,
        right: -80.w,
        child: Container(
          width: 350.w,
          height: 350.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFFAB91).withValues(alpha: 0.12),
          ),
        ),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: Container(color: Colors.transparent),
      ),
    ],
  );
  
  static Widget get buildRegisterBackground => Stack(
    children: [
      Positioned(
        top: -80,
        right: -80,
        child: Container(
          width: 250.w,
          height: 250.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF13C8EC).withValues(alpha: 0.15),
          ),
        ),
      ),
      Positioned(
        bottom: 80,
        left: -40,
        child: Container(
          width: 200.w,
          height: 200.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF2DD4BF).withValues(alpha: 0.15),
          ),
        ),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(color: Colors.transparent),
      ),
    ],
  );
}
