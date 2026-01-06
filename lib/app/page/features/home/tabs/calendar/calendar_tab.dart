import 'package:flutter/material.dart';
import '../../../../../core/theme/app.colors.dart';

class CalendarTab extends StatelessWidget {
  const CalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Calendar Tab')),
    );
  }
}
