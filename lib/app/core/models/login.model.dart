class LoginModel {
  final String email;
  final String password;

  const LoginModel({required this.email, required this.password});

  factory LoginModel.empty() => const LoginModel(email: '', password: '');

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

  LoginModel copyWith({String? email, String? password}) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  @override
  String toString() {
    return 'LoginModel(email: $email, password: ****)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginModel &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return email.hashCode ^ password.hashCode;
  }
}
