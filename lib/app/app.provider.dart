import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'core/utils/secure_storage.dart';
import 'page/auth/forgot/forgot.controller.dart';
import 'page/auth/register/register.controller.dart';
import 'page/home/home.controller.dart';
import 'page/auth/login/login.controller.dart';

class AppProvider {
  static List<SingleChildWidget> get providers => [
    ..._services,
    ..._repositories,
    ..._controllers,
  ];

  // 1. Camada de Infraestrutura/Serviços
  static final List<SingleChildWidget> _services = [
    Provider<SecureStorageService>(create: (_) => SecureStorageService()),
  ];

  // 2. Camada de Repositórios (Firebase, APIs, etc)
  static final List<SingleChildWidget> _repositories = [
    // Ex: RepositoryProvider(create: (context) => PetRepository(context.read())),
  ];

  // 3. Camada de Gerenciamento de Estado (BLoCs)
  static final List<SingleChildWidget> _controllers = [
    BlocProvider<HomeController>(create: (_) => HomeController()),
    BlocProvider<LoginController>(
      create: (context) => LoginController(context.read<SecureStorageService>()),
    ),
    BlocProvider<RegisterController>(create: (_) => RegisterController()),
    BlocProvider<ForgotController>(create: (_) => ForgotController()),
  ];
}
