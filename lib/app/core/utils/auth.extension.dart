import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../repository/auth.repository.dart';
import '../service/storage/token.storage.dart';

extension AuthContext on BuildContext {
  Future<void> logout() async {
    await read<IAuthRepository>().logout();
    await read<ITokenStorage>().clear();
    go('/');
  }
}
