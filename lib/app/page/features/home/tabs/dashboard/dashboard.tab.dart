import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
import '../../../../../core/widgets/error_state.widget.dart';
import '../../../../../core/widgets/header_features.widget.dart';
import 'dashboard.event.dart';
import 'use_case/dashboard.use_case.dart';
import 'widgets/pet_slider.widget.dart';
import 'dashboard.bloc.dart';
import 'dashboard.state.dart';
import 'widgets/schedule_card.widget.dart';
import 'widgets/sub_title.widget.dart';

class DashBoardTab extends StatelessWidget {
  const DashBoardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashBoardBloc(
        context.read<IAuthRepository>(),
        context.read<DashboardUseCase>(),
        context.read<IScheduleRepository>(),
        context.read<INotificationRepository>(),
      )..add(LoadDashboardData()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: Stack(
          children: [
            AppEffects.buildDashboardBackground,
            BlocConsumer<DashBoardBloc, DashBoardTabState>(
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
                final bloc = context.read<DashBoardBloc>();
                return switch (state) {
                  DashBoardTabLoading() || DashBoardTabInitial() =>
                    const Center(child: CircularProgressIndicator()),
                  DashBoardTabSuccess(
                    :final userName,
                    :final pets,
                    :final notifications,
                    :final todayTasks,
                  ) =>
                    SafeArea(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          HeaderFeaturesWidget(
                            style: HeaderStyle.home,
                            userName: StringHelper.formatUserName(userName),
                            notifications: notifications,
                            onDismissNotification: (n) =>
                                bloc.add(DismissNotification(n)),
                            margin: EdgeInsets.symmetric(horizontal: 24.w),
                          ),
                          SizedBox(height: 12.h),
                          PetSliderWidget(
                            pets: pets,
                            onPetPressed: (pet) =>
                                debugPrint('Pet: ${pet.name}'),
                          ),
                          SubTitleWidget(onTap: () => context.go('/calendar')),
                          SizedBox(height: 4.h),
                          ...todayTasks.map(
                            (task) => ScheduleCardWidget(
                              task: task,
                              onTap: () => bloc.add(ToggleTask(task)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  DashBoardTabError(:final message) => ErrorStateWidget(
                    message: message,
                    onPressed: () => bloc.add(LoadDashboardData()),
                  ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
