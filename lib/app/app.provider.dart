import 'package:firebase_auth/firebase_auth.dart';
import 'app.route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'core/repository/auth.repository.dart';
import 'core/repository/pet.repository.dart';
import 'core/service/firebase/firebase_auth.service.dart';
import 'core/service/storage/secure_storage.service.dart';
import 'core/service/storage/token.storage.dart';
import 'page/auth/forgot/forgot.controller.dart';
import 'page/auth/register/register.controller.dart';
// import 'page/features/home/home.controller.dart';
import 'page/auth/login/login.controller.dart';
import 'page/features/home/tabs/dashboard/dashboard.controller.dart';

class AppProvider {
  static List<SingleChildWidget> get providers => [
    ..._services,
    ..._domainStorages,
    ..._repositories,
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
  ];

  static final List<SingleChildWidget> _controllers = [
    BlocProvider<LoginController>(
      create: (context) => LoginController(context.read<IAuthRepository>()),
    ),
    BlocProvider<RegisterController>(
      create: (context) => RegisterController(context.read<IAuthRepository>()),
    ),
    BlocProvider<ForgotController>(
      create: (context) => ForgotController(context.read<IAuthRepository>()),
    ),
    BlocProvider<DashBoardTabController>(
      create: (context) => DashBoardTabController(
        context.read<IAuthRepository>(),
        context.read<IPetRepository>(),
      )..loadData(),
    ),
  ];
}
