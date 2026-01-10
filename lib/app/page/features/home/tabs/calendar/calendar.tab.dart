import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/models/features/notification.model.dart';
import '../../../../../core/repository/auth.repository.dart';
import '../../../../../core/repository/pet.repository.dart';
import '../../../../../core/repository/schedule.repository.dart';
import '../../../../../core/theme/app.colors.dart';
import '../../../../../core/theme/app.effects.dart';
import '../../../../../core/widgets/alert_dialog.widget.dart';
import '../../../../../core/widgets/header_features.widget.dart';
import 'calendar.controller.dart';
import 'calendar.state.dart';
import 'use_case/calendar.use_case.dart';
import 'widgets/calendar_slider_horizontal.widget.dart';
import 'widgets/mini_pet_selector.widget.dart';
import '../dashboard/widgets/schedule_card.widget.dart';

class CalendarTab extends StatelessWidget {
  const CalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarController(
        context.read<IAuthRepository>(),
        context.read<CalendarUseCase>(),
        context.read<IScheduleRepository>(),
      )..loadData(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            AppEffects.buildDashboardBackground,
            BlocConsumer<CalendarController, CalendarState>(
              listener: (context, state) {
                if (state is CalendarError) {
                  AlertDialogWidget.show(
                    context,
                    title: 'Erro',
                    message: state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is CalendarLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is CalendarSuccess) {
                  final filteredTasks = state.selectedPetId == null
                      ? state.todayTasks
                      : state.todayTasks
                            .where((t) => t.petId == state.selectedPetId)
                            .toList();

                  final pendingCount = filteredTasks
                      .where((t) => !t.isDone)
                      .length;
                  final List<NotificationModel> notifications =
                      state.notifications;

                  return SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        HeaderFeaturesWidget(
                          style: HeaderStyle.feature,
                          title: "Agenda de",
                          subtitle: "Outubro 2023",
                          notifications: notifications,
                        ),

                        SizedBox(height: 20.h),

                        // 1. Seletor de Pets (Mini Slider)
                        MiniPetSelectorWidget(
                          pets: state.pets,
                          selectedPetId: state.selectedPetId,
                          onPetSelected: (id) => context
                              .read<CalendarController>()
                              .filterByPet(id),
                        ),

                        SizedBox(height: 16.h),

                        // 2. Calendário Horizontal
                        CalendarSliderWidget(
                          selectedDate: state.selectedDate,
                          onDateSelected: (date) => context
                              .read<CalendarController>()
                              .changeDate(date),
                        ),

                        SizedBox(height: 24.h),

                        // 3. Título da Seção e Contador (Pequeno Badge)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tarefas de Hoje",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (pendingCount > 0)
                                _buildPendantBadge("$pendingCount Pendentes"),
                            ],
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // 4. Lista de Tarefas (Expanded para ocupar o resto e evitar overflow)
                        Expanded(
                          child: filteredTasks.isEmpty
                              ? _buildEmptyState()
                              : ListView.builder(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: filteredTasks.length,
                                  itemBuilder: (context, index) {
                                    final task = filteredTasks[index];
                                    return ScheduleCardWidget(
                                      task: task,
                                      onTap: () => context
                                          .read<CalendarController>()
                                          .toggleTask(task),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para o badge de pendências
  Widget _buildPendantBadge(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget para quando não houver tarefas no filtro
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_available, size: 50.sp, color: Colors.grey[300]),
          SizedBox(height: 12.h),
          Text(
            "Nenhuma tarefa para este dia.",
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
