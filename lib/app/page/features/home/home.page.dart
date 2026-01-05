import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/repository/auth.repository.dart';
import 'home.controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeController(context.read<IAuthRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logoff',
              onPressed: () {
                context.read<HomeController>().logout();
                context.go('/');
              },
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: () {}, child: const Text('Text Button')),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: 'Text Field',
                hintText: 'Enter some text',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
