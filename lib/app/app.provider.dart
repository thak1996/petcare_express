import 'package:firebase_auth/firebase_auth.dart';
import 'app.route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'core/repository/auth.repository.dart';
import 'core/repository/notification.repository.dart';
import 'core/repository/pet.repository.dart';
import 'core/repository/schedule.repository.dart';
import 'core/service/firebase/firebase_auth.service.dart';
import 'core/service/storage/secure_storage.service.dart';
import 'core/service/storage/token.storage.dart';
import 'page/auth/forgot/forgot.bloc.dart';
import 'page/auth/register/register.controller.dart';
import 'page/auth/login/login.bloc.dart';
import 'page/features/home/tabs/calendar/calendar.bloc.dart';
import 'page/features/home/tabs/calendar/calendar.event.dart';
import 'page/features/home/tabs/calendar/use_case/calendar.use_case.dart';
import 'page/features/home/tabs/dashboard/dashboard.bloc.dart';
import 'page/features/home/tabs/dashboard/dashboard.event.dart';
import 'page/features/home/tabs/dashboard/use_case/dashboard.use_case.dart';

class AppProvider {
  static List<SingleChildWidget> get providers => [
    ..._services,
    ..._domainStorages,
    ..._repositories,
    ..._useCases,
    ..._controllers,
  ];

  static final List<SingleChildWidget> _services = [
    Provider<ISecureStorage>(
      create: (_) => SecureStorageImpl(const FlutterSecureStorage()),
    ),
    Provider<IFirebaseAuthService>(
      create: (_) => FirebaseAuthServiceImpl(FirebaseAuth.instance),
    ),
  ];

  static final List<SingleChildWidget> _domainStorages = [
    ProxyProvider<ISecureStorage, ITokenStorage>(
      update: (_, secureService, __) => TokenStorageImpl(secureService),
    ),
    ProxyProvider<ITokenStorage, AppRouter>(
      update: (_, tokenStorage, __) => AppRouter(tokenStorage),
    ),
  ];

  static final List<SingleChildWidget> _repositories = [
    ProxyProvider2<ITokenStorage, IFirebaseAuthService, IAuthRepository>(
      update: (_, tokenStorage, firebaseAuthService, __) =>
          AuthRepositoryImpl(tokenStorage, firebaseAuthService),
    ),
    Provider<IPetRepository>(create: (context) => PetRepositoryImpl()),
    Provider<INotificationRepository>(
      create: (context) => NotificationRepositoryImpl(),
    ),
    Provider<IScheduleRepository>(create: (_) => ScheduleRepositoryImpl()),
  ];

  static final List<SingleChildWidget> _useCases = [
    RepositoryProvider<CalendarUseCase>(
      create: (context) => CalendarUseCase(
        context.read<IPetRepository>(),
        context.read<IScheduleRepository>(),
        context.read<INotificationRepository>(),
      ),
    ),
    RepositoryProvider<DashboardUseCase>(
      create: (context) => DashboardUseCase(
        context.read<IPetRepository>(),
        context.read<IScheduleRepository>(),
        context.read<INotificationRepository>(),
      ),
    ),
  ];

  static final List<SingleChildWidget> _controllers = [
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(context.read<IAuthRepository>()),
    ),
    BlocProvider<RegisterController>(
      create: (context) => RegisterController(context.read<IAuthRepository>()),
    ),
    BlocProvider<ForgotBloc>(
      create: (context) => ForgotBloc(context.read<IAuthRepository>()),
    ),
    BlocProvider<DashBoardBloc>(
      create: (context) => DashBoardBloc(
        context.read<IAuthRepository>(),
        context.read<DashboardUseCase>(),
        context.read<IScheduleRepository>(),
        context.read<INotificationRepository>(),
      )..add(LoadDashboardData()),
    ),
    BlocProvider<CalendarBloc>(
      create: (context) => CalendarBloc(
        context.read<IAuthRepository>(),
        context.read<CalendarUseCase>(),
        context.read<IScheduleRepository>(),
        context.read<INotificationRepository>(),
      )..add(LoadCalendarData()),
    ),
  ];
}
