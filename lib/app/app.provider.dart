import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'app.route.dart';
import 'core/service/storage/secure_storage.service.dart';
import 'core/service/storage/token.storage.dart';
import 'page/auth/forgot/forgot.controller.dart';
import 'page/auth/register/register.controller.dart';
import 'page/features/home/home.controller.dart';
import 'page/auth/login/login.controller.dart';

class AppProvider {
  static List<SingleChildWidget> get providers => [
    ..._services,
    ..._repositories,
    ..._domainStorages,
    ..._controllers,
  ];

  // 1. Camada de Infraestrutura/Serviços
  static final List<SingleChildWidget> _services = [
    Provider<SecureStorageImpl>(
      create: (_) => SecureStorageImpl(FlutterSecureStorage()),
    ),
  ];

  // 2. Camada de Repositórios (Firebase, APIs, etc)
  static final List<SingleChildWidget> _repositories = [
    // Ex: RepositoryProvider(create: (context) => PetRepository(context.read())),
  ];

  static final List<SingleChildWidget> _domainStorages = [
    ProxyProvider<ISecureStorage, ITokenStorage>(
      update: (_, secureService, __) => TokenStorageImpl(secureService),
    ),
    ProxyProvider<ITokenStorage, AppRouter>(
      update: (_, tokenStorage, __) => AppRouter(tokenStorage),
    ),
  ];

  // 3. Camada de Gerenciamento de Estado (BLoCs)
  static final List<SingleChildWidget> _controllers = [
    BlocProvider<HomeController>(create: (_) => HomeController()),
    BlocProvider<LoginController>(
      create: (context) => LoginController(context.read<ITokenStorage>()),
    ),
    BlocProvider<RegisterController>(create: (_) => RegisterController()),
    BlocProvider<ForgotController>(create: (_) => ForgotController()),
  ];
}
