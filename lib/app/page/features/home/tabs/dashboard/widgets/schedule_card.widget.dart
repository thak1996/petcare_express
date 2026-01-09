import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/models/features/schedule.model.dart';
import '../../../../../../core/theme/app.colors.dart';

class ScheduleCardWidget extends StatelessWidget {
  final ScheduleModel task;
  final VoidCallback? onTap;

  const ScheduleCardWidget({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    final double opacity = task.isDone ? 0.5 : 1.0;
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, left: 24.w, right: 24.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: task.isDone ? Colors.grey.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          if (!task.isDone)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: task.isDone
                  ? Colors.grey.shade200
                  : task.themeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              task.icon,
              color: task.isDone ? Colors.grey : task.themeColor,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87.withValues(alpha: opacity),
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Text(
                      task.petName,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        "•",
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                    _buildCategoryTag(),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        "${task.time} • ${task.subtitle}",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey.shade500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          _buildCheckButton(),
        ],
      ),
    );
  }

  Widget _buildCategoryTag() {
    final backgroundColor = task.isDone
        ? Colors.grey.shade200
        : task.themeColor.withValues(alpha: 0.1);
    final textColor = task.isDone ? Colors.grey.shade500 : task.themeColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        task.translation.toUpperCase(),
        style: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildCheckButton() {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 32.r,
        height: 32.r,
        decoration: BoxDecoration(
          color: task.isDone ? const Color(0xFF4ECDC4) : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: task.isDone ? Colors.transparent : Colors.grey.shade200,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.check,
          color: task.isDone ? Colors.white : Colors.transparent,
          size: 18.sp,
        ),
      ),
    );
  }
}
