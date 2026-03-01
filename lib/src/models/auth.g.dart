// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
  roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
  email: json['email'] as String,
  username: json['username'] as String,
  bio: json['bio'] as String?,
  image: json['image'] as String?,
  backgroundImage: json['backgroundImage'] as String?,
  points: toInt(json['points']),
  token: json['token'] as String?,
);

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
  'roles': instance.roles,
  'email': instance.email,
  'username': instance.username,
  'bio': instance.bio,
  'image': instance.image,
  'backgroundImage': instance.backgroundImage,
  'points': instance.points,
  'token': instance.token,
};

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  user: UserDTO.fromJson(json['user'] as Map<String, dynamic>),
  refreshToken: json['refreshToken'] as String?,
  expiresIn: toInt(json['expiresIn']),
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };

TokenPairDTO _$TokenPairDTOFromJson(Map<String, dynamic> json) => TokenPairDTO(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresIn: toInt(json['expiresIn']),
);

Map<String, dynamic> _$TokenPairDTOToJson(TokenPairDTO instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };
