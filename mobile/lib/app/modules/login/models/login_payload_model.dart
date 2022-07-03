import 'dart:convert';

class LoginPayloadModel {
  final String email;
  final String password;

  LoginPayloadModel({
    required this.email,
    required this.password,
  });

  LoginPayloadModel copyWith({
    String? email,
    String? password,
  }) {
    return LoginPayloadModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'LoginPayloadModel(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginPayloadModel && other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
