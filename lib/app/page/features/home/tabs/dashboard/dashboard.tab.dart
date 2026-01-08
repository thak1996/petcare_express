import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petcare_express/app/core/repository/auth.repository.dart';
import 'package:petcare_express/app/core/widgets/logout_button.widget.dart';
import '../../../../../core/models/features/notification.model.dart';
import '../../../../../core/models/features/pet.model.dart';
import '../../../../../core/repository/notification.repository.dart';
import '../../../../../core/repository/pet.repository.dart';
import '../../../../../core/theme/app.colors.dart';
import '../../../../../core/theme/app.effects.dart';
import '../../../../../core/utils/string.utils.dart';
import '../../../../../core/widgets/alert_dialog.widget.dart';
import 'widgets/dashboard_header.widget.dart';
import 'widgets/pet_slider.widget.dart';
import 'dashboard.controller.dart';
import 'dashboard.state.dart';

class DashBoardTab extends StatelessWidget {
  const DashBoardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashBoardTabController(
        context.read<IAuthRepository>(),
        context.read<IPetRepository>(),
        context.read<INotificationRepository>(),
      )..loadData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: Stack(
          children: [
            AppEffects.buildDashboardBackground,
            BlocConsumer<DashBoardTabController, DashBoardTabState>(
              listener: (context, state) {
                if (state is DashBoardTabError) {
                  AlertDialogWidget.show(
                    context,
                    title: 'Erro',
                    message: state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is DashBoardTabLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final controller = context.read<DashBoardTabController>();
                final String userName = (state is DashBoardTabSuccess)
                    ? state.userName
                    : 'Usuário';
                final List<PetModel> pets = (state is DashBoardTabSuccess)
                    ? state.pets
                    : [];
                final List<NotificationModel> notifications =
                    (state is DashBoardTabSuccess) ? state.notifications : [];
                final formattedName = StringHelper.formatUserName(userName);
                return SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () =>
                        context.read<DashBoardTabController>().loadData(),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(height: 20.h),
                        DashboardHeaderWidget(
                          userName: formattedName,
                          notifications: notifications,
                          onDismissNotification: (notification) =>
                              controller.dismissNotification(notification),
                          margin: EdgeInsets.symmetric(horizontal: 24.w),
                        ),
                        SizedBox(height: 14.h),
                        PetSliderWidget(
                          pets: pets,
                          onPetPressed: (pet) => debugPrint('Pet: ${pet.name}'),
                        ),
                        SubTitleWidget(
                          onTap: () => debugPrint('Ver tudo agenda'),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
