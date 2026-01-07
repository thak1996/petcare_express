import 'package:flutter/material.dart';
import '../../../../../core/theme/app.colors.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Profile Tab')),
    );
  }
}
