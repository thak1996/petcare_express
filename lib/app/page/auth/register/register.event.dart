import 'package:petcare_express/app/core/models/auth/user.model.dart';

abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final UserModel userModel;

  RegisterSubmitted({required this.userModel});
}
