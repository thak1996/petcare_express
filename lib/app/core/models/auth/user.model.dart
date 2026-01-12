import 'package:hive/hive.dart';

part 'user.model.g.dart';

@HiveType(typeId: 5)
class UserModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? password;
  @HiveField(3)
  final String? email;
  @HiveField(4)
  final String? token;

  UserModel({this.id, this.name, this.password, this.email, this.token});

  factory UserModel.empty() => UserModel(id: null);
}
