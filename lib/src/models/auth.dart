import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class UserDTO {
  final List<String> roles;
  final String email;
  final String username;
  final String? bio;
  final String? image;
  final String? backgroundImage;
  final num? points;
  final String? token; // In API docs this is sometimes present

  UserDTO({
    required this.roles,
    required this.email,
    required this.username,
    this.bio,
    this.image,
    this.backgroundImage,
    this.points,
    this.token,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}

@JsonSerializable()
class UserResponse {
  final UserDTO user;
  final String? refreshToken;
  final int? expiresIn;

  UserResponse({required this.user, this.refreshToken, this.expiresIn});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class TokenPairDTO {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  TokenPairDTO({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory TokenPairDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenPairDTOFromJson(json);
  Map<String, dynamic> toJson() => _$TokenPairDTOToJson(this);
}
