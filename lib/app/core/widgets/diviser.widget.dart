import '../theme/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DivisorWidget extends StatefulWidget {
  const DivisorWidget({super.key, this.isNewAccount});

  final bool? isNewAccount;

  @override
  State<DivisorWidget> createState() => _DivisorWidgetState();
}

class _DivisorWidgetState extends State<DivisorWidget> {
  final String textDefault = 'Ou continue com';
  final String textNewAccount = 'Ou registre com';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.grey300, thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: Text(
              widget.isNewAccount ?? false ? textNewAccount : textDefault,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSubtitle),
            ),
          ),
          Expanded(child: Divider(color: AppColors.grey300, thickness: 1)),
        ],
      ),
    );
  }
}
