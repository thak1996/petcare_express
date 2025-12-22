import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'core/utils/secure_storage.dart';
import 'page/auth/register/register.controller.dart';
import 'page/home/home.controller.dart';
import 'page/auth/login/login.controller.dart';

class AppProvider {
  static List<SingleChildWidget> get providers => [
    BlocProvider<HomeController>(create: (_) => HomeController()),
    BlocProvider<LoginController>(
      create: (_) => LoginController(SecureStorageService()),
    ),
    BlocProvider<RegisterController>(create: (_) => RegisterController()),
    Provider<SecureStorageService>(create: (_) => SecureStorageService()),
  ];
}