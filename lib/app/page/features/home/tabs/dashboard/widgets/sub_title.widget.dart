import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../../../core/theme/app.colors.dart';

class SubTitleWidget extends StatelessWidget {
  const SubTitleWidget({required this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "Agenda de Hoje",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 18.sp,
                color: AppColors.textSubtitle,
              ),
            ),
            SizedBox(width: 10.w),
            Icon(IonIcons.calendar, size: 18.sp, color: AppColors.textSubtitle),
          ],
        ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Text(
              "Ver tudo",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12.sp,
                color: AppColors.link,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
