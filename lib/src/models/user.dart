import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String email;
  final String username;
  final String? bio;
  final String? image;
  final String? token;

  User({
    required this.id,
    required this.email,
    required this.username,
    this.bio,
    this.image,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class SocialMediaLink {
  final String platform;
  final String url;

  SocialMediaLink({required this.platform, required this.url});

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaLinkFromJson(json);
  Map<String, dynamic> toJson() => _$SocialMediaLinkToJson(this);
}

@JsonSerializable()
class Profile {
  final int id;
  final String name;
  final String? username;
  final String? bio;
  final String? image;
  final String? backgroundImage;
  final bool following;
  final List<SocialMediaLink> socialMediaLinks;

  Profile({
    required this.id,
    required this.name,
    this.username,
    this.bio,
    this.image,
    this.backgroundImage,
    required this.following,
    required this.socialMediaLinks,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
