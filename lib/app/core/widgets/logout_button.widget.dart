import 'package:flutter/material.dart';
import 'package:petcare_express/app/core/utils/auth.extension.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
    icon: const Icon(Icons.logout),
    tooltip: 'Logoff',
    onPressed: () => context.logout(),
  );
}
