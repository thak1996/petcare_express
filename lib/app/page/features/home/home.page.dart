import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petcare_express/app/core/utils/auth.extension.dart';
import 'package:petcare_express/app/core/widgets/logout_button.widget.dart';
import '../../../core/repository/auth.repository.dart';
import 'home.controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => HomeController(context.read<IAuthRepository>()),
    child: Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [LogoutButtonWidget(), const SizedBox(width: 16)],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        ],
      ),
    ),
  );
}
