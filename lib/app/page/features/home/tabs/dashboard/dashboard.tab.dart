import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petcare_express/app/core/repository/auth.repository.dart';
import 'package:petcare_express/app/core/widgets/logout_button.widget.dart';
import '../../../../../core/theme/app.colors.dart';
import '../../../../../core/utils/string.utils.dart';
import 'dashboard.controller.dart';
import 'dashboard.state.dart';

class DashBoardTab extends StatelessWidget {
  const DashBoardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashBoardTabController(context.read<IAuthRepository>())..loadData(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocConsumer<DashBoardTabController, DashBoardTabState>(
          listener: (context, state) {
            if (state is DashBoardTabError) {}
          },
          builder: (context, state) {
            final controller = context.read<DashBoardTabController>();
            if (state is DashBoardTabLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final userName = (state is DashBoardTabSuccess)
                ? state.userName
                : 'UserName';
            final formattedName = StringHelper.formatUserName(userName);
            return SafeArea(
              child: RefreshIndicator(
                onRefresh: () async => controller.loadData(),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bom dia,",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontSize: 14.sp),
                              ),
                              Text(
                                "$formattedName! 👋",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontSize: 18.sp),
                              ),
                            ],
                          ),
                        ),
                        _buildNotificationIcon(),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    LogoutButtonWidget(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          child: Icon(
            Icons.notifications_none_rounded,
            size: 24.sp,
            color: Colors.black87,
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            width: 8.r,
            height: 8.r,
            decoration: BoxDecoration(
              color: Colors.orange.shade700,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
