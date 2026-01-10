import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app.colors.dart';

class CalendarSliderWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarSliderWidget({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        physics: const BouncingScrollPhysics(),
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = DateTime.now().add(Duration(days: index));
          final bool isSelected =
              date.day == selectedDate.day && date.month == selectedDate.month;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 65.w,
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    )
                  else
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getWeekDay(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white70 : Colors.grey,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    date.day.toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isSelected) ...[
                    SizedBox(height: 4.h),
                    Container(
                      width: 4.r,
                      height: 4.r,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getWeekDay(DateTime date) {
    final days = ['SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SÁB', 'DOM'];
    return days[date.weekday - 1];
  }
}
