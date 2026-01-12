import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/models/features/notification.model.dart';
import '../../../../../core/repository/auth.repository.dart';
import '../../../../../core/repository/notification.repository.dart';
import '../../../../../core/repository/schedule.repository.dart';
import '../../../../../core/theme/app.colors.dart';
import '../../../../../core/theme/app.effects.dart';
import '../../../../../core/utils/string.utils.dart';
import '../../../../../core/widgets/alert_dialog.widget.dart';
import '../../../../../core/widgets/error_state.widget.dart';
import '../../../../../core/widgets/header_features.widget.dart';
import 'calendar.bloc.dart';
import 'calendar.event.dart';
import 'calendar.state.dart';
import 'use_case/calendar.use_case.dart';
import 'widgets/calendar_slider_horizontal.widget.dart';
import 'widgets/mini_pet_selector.widget.dart';
import '../dashboard/widgets/schedule_card.widget.dart';

class CalendarTab extends StatelessWidget {
  const CalendarTab({super.key});

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc(
        context.read<IAuthRepository>(),
        context.read<CalendarUseCase>(),
        context.read<IScheduleRepository>(),
        context.read<INotificationRepository>(),
      )..add(LoadCalendarData()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            AppEffects.buildDashboardBackground,
            BlocConsumer<CalendarBloc, CalendarState>(
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
                final bloc = context.read<CalendarBloc>();
                return switch (state) {
                  CalendarInitial() || CalendarLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  CalendarSuccess(
                    :final currentTasks,
                    :final pets,
                    :final selectedPetId,
                    :final selectedDate,
                    :final notifications,
                  ) =>
                    Builder(
                      builder: (context) {
                        final filteredTasks = selectedPetId == null
                            ? currentTasks
                            : currentTasks
                                  .where((t) => t.petId == selectedPetId)
                                  .toList();
                        final pendingCount = filteredTasks
                            .where((t) => !t.isDone)
                            .length;
                        final monthName = DateFormat(
                          'MMMM yyyy',
                          'pt_BR',
                        ).format(selectedDate);
                        final listTitle = _isToday(selectedDate)
                            ? "Tarefas de Hoje"
                            : "Tarefas de ${DateFormat('dd/MM', 'pt_BR').format(selectedDate)}";
                        return SafeArea(
                          child: Column(
                            children: [
                              // TODO: Ajustar o Subtitle para refletir com o nome do mês dinâmicamente
                              HeaderFeaturesWidget(
                                style: HeaderStyle.feature,
                                title: "Agenda de",
                                subtitle: StringHelper.capitalize(monthName),
                                notifications: notifications,
                              ),
                              // TODO: Ajustar o Componente para ser possível clicar em "todos"
                              MiniPetSelectorWidget(
                                pets: pets,
                                selectedPetId: selectedPetId,
                                onPetSelected: (id) =>
                                    bloc.add(FilterByPet(id)),
                              ),
                              // TODO: Reduzir altura do Componente de Data
                              CalendarSliderWidget(
                                selectedDate: selectedDate,
                                onDateSelected: (date) =>
                                    bloc.add(ChangeSelectedDate(date)),
                              ),
                              SizedBox(height: 12.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      listTitle,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (pendingCount > 0)
                                      _buildPendantBadge(
                                        "$pendingCount Pendentes",
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Expanded(
                                child: filteredTasks.isEmpty
                                    ? _buildEmptyState()
                                    : ListView.builder(
                                        padding: EdgeInsets.only(bottom: 80.h),
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: filteredTasks.length,
                                        itemBuilder: (context, index) {
                                          final task = filteredTasks[index];
                                          return ScheduleCardWidget(
                                            task: task,
                                            onTap: () => bloc.add(
                                              ToggleCalendarTask(task),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  CalendarError(:final message) => ErrorStateWidget(
                    message: message,
                    onPressed: () => bloc.add(LoadCalendarData()),
                  ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendantBadge(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
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
