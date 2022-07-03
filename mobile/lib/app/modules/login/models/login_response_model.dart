import 'dart:convert';

class LoginResponseModel {
  final String accessToken;

  LoginResponseModel({
    required this.accessToken,
  });

  LoginResponseModel copyWith({
    String? accessToken,
  }) {
    return LoginResponseModel(
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      accessToken: map['access_token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginResponseModel(accessToken: $accessToken)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginResponseModel && other.accessToken == accessToken;
  }

  @override
  int get hashCode => accessToken.hashCode;
}
