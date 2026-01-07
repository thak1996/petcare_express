import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petcare_express/app/core/repository/auth.repository.dart';
import 'dashboard.controller.dart';
import 'dashboard.state.dart';

class DashBoardTab extends StatelessWidget {
  const DashBoardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashBoardTabController(context.read<IAuthRepository>()),
      child: Scaffold(
        appBar: AppBar(title: const Text('DashboardTab')),
        body: BlocConsumer<DashBoardTabController, DashBoardTabState>(
          listener: (context, state) {
            if (state is DashBoardTabError) {}
          },
          builder: (context, state) {
            final controller = context.read<DashBoardTabController>();
            if (state is DashBoardTabLoading) {
              const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Página DashboardTab'),
                  ElevatedButton(
                    onPressed: () => controller.loadData(),
                    child: const Text('Executar Ação'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
