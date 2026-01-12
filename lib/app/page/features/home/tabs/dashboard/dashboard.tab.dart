import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:petcare_express/app/core/repository/auth.repository.dart';
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
                    Builder(
                      builder: (context) {
                        final sortedTasks = List<ScheduleModel>.from(todayTasks)
                          ..sort((a, b) {
                            if (a.isDone && !b.isDone) return 1;
                            if (!a.isDone && b.isDone) return -1;
                            return a.time.compareTo(b.time);
                          });

                        return SafeArea(
                          child: Column(
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
                              SubTitleWidget(
                                onTap: () => context.go('/calendar'),
                              ),
                              SizedBox(height: 4.h),
                              Expanded(
                                child: sortedTasks.isEmpty
                                    ? _buildEmptyState()
                                    : ListView.separated(
                                        padding: EdgeInsets.only(bottom: 20.h),
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: sortedTasks.length,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 0.h),
                                        itemBuilder: (context, index) {
                                          final task = sortedTasks[index];
                                          return ScheduleCardWidget(
                                            task: task,
                                            onTap: () =>
                                                bloc.add(ToggleTask(task)),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        );
                      },
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_available, size: 50.sp, color: Colors.grey[300]),
          SizedBox(height: 12.h),
          Text(
            "Nenhuma tarefa para hoje!",
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
