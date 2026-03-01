import 'package:json_annotation/json_annotation.dart';

part 'common.g.dart';

/// Helper to safely parse int from dynamic values (String or num)
int toInt(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v.toInt();
  return int.tryParse(v.toString()) ?? 0;
}

/// Helper to safely parse double from dynamic values (String or num)
double buildToDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0.0;
}

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  final List<T> items;
  @JsonKey(fromJson: toInt)
  final int total;
  @JsonKey(fromJson: toInt)
  final int page;
  @JsonKey(fromJson: toInt)
  final int pageSize;

  PaginatedResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);
}

@JsonSerializable()
class Author {
  @JsonKey(fromJson: toInt)
  final int? id;
  final String name;
  final String? username;
  final String? bio;
  final String? image;
  final String? backgroundImage;
  final bool? following;

  Author({
    this.id,
    required this.name,
    this.username,
    this.bio,
    this.image,
    this.backgroundImage,
    this.following,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class Download {
  @JsonKey(fromJson: toInt)
  final int id;
  final String name;
  final String url;
  final bool isActive;
  final bool vipOnly;
  final String? createdAt;

  Download({
    required this.id,
    required this.name,
    required this.url,
    required this.isActive,
    required this.vipOnly,
    this.createdAt,
  });

  factory Download.fromJson(Map<String, dynamic> json) =>
      _$DownloadFromJson(json);
  Map<String, dynamic> toJson() => _$DownloadToJson(this);
}

@JsonSerializable()
class OfficialDownloadSource {
  final String id;
  final String name;
  final String url;
  final String status;

  OfficialDownloadSource({
    required this.id,
    required this.name,
    required this.url,
    required this.status,
  });

  factory OfficialDownloadSource.fromJson(Map<String, dynamic> json) =>
      _$OfficialDownloadSourceFromJson(json);
  Map<String, dynamic> toJson() => _$OfficialDownloadSourceToJson(this);
}

@JsonSerializable()
class Mod {
  @JsonKey(fromJson: toInt)
  final int id;
  final String name;
  final String description;
  final String creditTo;
  final String downloadLink;
  final String version;
  final String status;
  final List<NamedEntity> categories;
  final List<ImageObject> images;
  final ModCreator creator;

  Mod({
    required this.id,
    required this.name,
    required this.description,
    required this.creditTo,
    required this.downloadLink,
    required this.version,
    required this.status,
    required this.categories,
    required this.images,
    required this.creator,
  });

  factory Mod.fromJson(Map<String, dynamic> json) => _$ModFromJson(json);
  Map<String, dynamic> toJson() => _$ModToJson(this);
}

@JsonSerializable()
class ModCreator {
  final String name;
  final String? image;

  ModCreator({required this.name, this.image});

  factory ModCreator.fromJson(Map<String, dynamic> json) =>
      _$ModCreatorFromJson(json);
  Map<String, dynamic> toJson() => _$ModCreatorToJson(this);
}

@JsonSerializable()
class NamedEntity {
  final String id;
  final String name;

  NamedEntity({required this.id, required this.name});

  factory NamedEntity.fromJson(Map<String, dynamic> json) =>
      _$NamedEntityFromJson(json);
  Map<String, dynamic> toJson() => _$NamedEntityToJson(this);
}

@JsonSerializable()
class ImageObject {
  final String? id;
  final String url;

  ImageObject({this.id, required this.url});

  factory ImageObject.fromJson(Map<String, dynamic> json) =>
      _$ImageObjectFromJson(json);
  Map<String, dynamic> toJson() => _$ImageObjectToJson(this);
}
