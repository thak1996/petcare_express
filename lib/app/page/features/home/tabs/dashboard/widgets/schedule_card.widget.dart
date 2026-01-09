import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/models/features/schedule.model.dart';

class ScheduleCardWidget extends StatelessWidget {
  final ScheduleModel task;
  final VoidCallback? onTap;

  const ScheduleCardWidget({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    final double opacity = task.isDone ? 0.6 : 1.0;

    return Container(
      margin: EdgeInsets.only(bottom: 6.h, left: 24.w, right: 24.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: task.isDone ? Colors.grey.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87.withValues(alpha: opacity),
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14.sp, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Text(
                      "${task.time} • ${task.subtitle}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: task.isDone
                    ? const Color(0xFF4ECDC4)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: task.isDone ? Colors.white : Colors.grey.shade300,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
