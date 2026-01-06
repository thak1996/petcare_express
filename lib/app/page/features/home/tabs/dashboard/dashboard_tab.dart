import 'package:flutter/material.dart';
import '../../../../../core/theme/app.colors.dart';

class DashBoardTab extends StatelessWidget {
  const DashBoardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Dashboard Tab')),
    );
  }
}
