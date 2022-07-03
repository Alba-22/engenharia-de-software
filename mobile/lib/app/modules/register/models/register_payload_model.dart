import 'dart:convert';

class RegisterPayloadModel {
  final String name;
  final String email;
  final String phone;
  final String password;

  RegisterPayloadModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  RegisterPayloadModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) {
    return RegisterPayloadModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory RegisterPayloadModel.fromMap(Map<String, dynamic> map) {
    return RegisterPayloadModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterPayloadModel.fromJson(String source) =>
      RegisterPayloadModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterPayloadModel(name: $name, email: $email, phone: $phone, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterPayloadModel &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.password == password;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ phone.hashCode ^ password.hashCode;
  }
}
