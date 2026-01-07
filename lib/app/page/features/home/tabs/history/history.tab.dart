import 'package:flutter/material.dart';
import '../../../../../core/theme/app.colors.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('History Tab')),
    );
  }
}
