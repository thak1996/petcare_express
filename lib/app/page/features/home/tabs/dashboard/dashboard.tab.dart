import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petcare_express/app/core/repository/auth.repository.dart';
import 'package:petcare_express/app/core/widgets/logout_button.widget.dart';
import '../../../../../core/models/features/notification.model.dart';
import '../../../../../core/models/features/pet.model.dart';
import '../../../../../core/models/features/schedule.model.dart';
import '../../../../../core/repository/notification.repository.dart';
import '../../../../../core/repository/pet.repository.dart';
import '../../../../../core/repository/schedule.repository.dart';
import '../../../../../core/theme/app.colors.dart';
import '../../../../../core/theme/app.effects.dart';
import '../../../../../core/utils/string.utils.dart';
import '../../../../../core/widgets/alert_dialog.widget.dart';
import 'widgets/dashboard_header.widget.dart';
import 'widgets/pet_slider.widget.dart';
import 'dashboard.controller.dart';
import 'dashboard.state.dart';
import 'widgets/schedule_card.widget.dart';
import 'widgets/sub_title.widget.dart';

class DashBoardTab extends StatelessWidget {
  const DashBoardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashBoardTabController(
        context.read<IAuthRepository>(),
        context.read<IPetRepository>(),
        context.read<INotificationRepository>(),
        context.read<IScheduleRepository>(),
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
                final List<ScheduleModel> tasks = (state is DashBoardTabSuccess)
                    ? state.todayTasks
                    : [];
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
                        SizedBox(height: 8.h),
                        ...tasks.map(
                          (task) => ScheduleCardWidget(
                            task: task,
                            onTap: () => controller.toggleTask(task),
                          ),
                        ),
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
