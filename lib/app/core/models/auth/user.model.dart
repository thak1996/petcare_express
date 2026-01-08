class UserModel {
  final String? id;
  final String? name;
  final String? password;
  final String? email;
  final String? token;

  UserModel({this.id, this.name, this.password, this.email, this.token});

  factory UserModel.empty() {
    return UserModel(
      id: null,
      name: null,
      password: null,
      email: null,
      token: null,
    );
  }
}
