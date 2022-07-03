import 'dart:convert';

class RegisterResponseModel {
  final String accessToken;

  RegisterResponseModel({
    required this.accessToken,
  });

  RegisterResponseModel copyWith({
    String? accessToken,
  }) {
    return RegisterResponseModel(
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
    };
  }

  factory RegisterResponseModel.fromMap(Map<String, dynamic> map) {
    return RegisterResponseModel(
      accessToken: map['access_token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterResponseModel.fromJson(String source) =>
      RegisterResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RegisterResponseModel(accessToken: $accessToken)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterResponseModel && other.accessToken == accessToken;
  }

  @override
  int get hashCode => accessToken.hashCode;
}
