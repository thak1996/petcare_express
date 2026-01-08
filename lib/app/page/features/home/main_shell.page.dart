import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petcare_express/app/core/theme/app.colors.dart';
import 'package:petcare_express/app/core/utils/auth.extension.dart';
import 'package:petcare_express/app/core/widgets/logout_button.widget.dart';
import '../../../core/repository/auth.repository.dart';
import 'tabs/calendar/calendar.tab.dart';
import 'tabs/dashboard/dashboard.tab.dart';
import 'tabs/history/history.tab.dart';
import 'tabs/profile/profile.tab.dart';
import 'widgets/petcare_navigation_bar.widget.dart';

class MainShellView extends StatefulWidget {
  const MainShellView({super.key});

  @override
  State<MainShellView> createState() => _MainShellViewState();
}

class _MainShellViewState extends State<MainShellView> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const DashBoardTab(),
    const HistoryTab(),
    const CalendarTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: PetcareNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
