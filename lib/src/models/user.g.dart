// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  username: json['username'] as String,
  bio: json['bio'] as String?,
  image: json['image'] as String?,
  token: json['token'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'username': instance.username,
  'bio': instance.bio,
  'image': instance.image,
  'token': instance.token,
};

SocialMediaLink _$SocialMediaLinkFromJson(Map<String, dynamic> json) =>
    SocialMediaLink(
      platform: json['platform'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$SocialMediaLinkToJson(SocialMediaLink instance) =>
    <String, dynamic>{'platform': instance.platform, 'url': instance.url};

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  username: json['username'] as String?,
  bio: json['bio'] as String?,
  image: json['image'] as String?,
  backgroundImage: json['backgroundImage'] as String?,
  following: json['following'] as bool,
  socialMediaLinks: (json['socialMediaLinks'] as List<dynamic>)
      .map((e) => SocialMediaLink.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'bio': instance.bio,
  'image': instance.image,
  'backgroundImage': instance.backgroundImage,
  'following': instance.following,
  'socialMediaLinks': instance.socialMediaLinks,
};
