// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResponse<T> _$PaginatedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PaginatedResponse<T>(
  items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
  total: toInt(json['total']),
  page: toInt(json['page']),
  pageSize: toInt(json['pageSize']),
);

Map<String, dynamic> _$PaginatedResponseToJson<T>(
  PaginatedResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'items': instance.items.map(toJsonT).toList(),
  'total': instance.total,
  'page': instance.page,
  'pageSize': instance.pageSize,
};

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
  id: toInt(json['id']),
  name: json['name'] as String,
  username: json['username'] as String?,
  bio: json['bio'] as String?,
  image: json['image'] as String?,
  backgroundImage: json['backgroundImage'] as String?,
  following: json['following'] as bool?,
);

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'bio': instance.bio,
  'image': instance.image,
  'backgroundImage': instance.backgroundImage,
  'following': instance.following,
};

Download _$DownloadFromJson(Map<String, dynamic> json) => Download(
  id: toInt(json['id']),
  name: json['name'] as String,
  url: json['url'] as String,
  isActive: json['isActive'] as bool,
  vipOnly: json['vipOnly'] as bool,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$DownloadToJson(Download instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'url': instance.url,
  'isActive': instance.isActive,
  'vipOnly': instance.vipOnly,
  'createdAt': instance.createdAt,
};

OfficialDownloadSource _$OfficialDownloadSourceFromJson(
  Map<String, dynamic> json,
) => OfficialDownloadSource(
  id: json['id'] as String,
  name: json['name'] as String,
  url: json['url'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$OfficialDownloadSourceToJson(
  OfficialDownloadSource instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'url': instance.url,
  'status': instance.status,
};

Mod _$ModFromJson(Map<String, dynamic> json) => Mod(
  id: toInt(json['id']),
  name: json['name'] as String,
  description: json['description'] as String,
  creditTo: json['creditTo'] as String,
  downloadLink: json['downloadLink'] as String,
  version: json['version'] as String,
  status: json['status'] as String,
  categories: (json['categories'] as List<dynamic>)
      .map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  images: (json['images'] as List<dynamic>)
      .map((e) => ImageObject.fromJson(e as Map<String, dynamic>))
      .toList(),
  creator: ModCreator.fromJson(json['creator'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ModToJson(Mod instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'creditTo': instance.creditTo,
  'downloadLink': instance.downloadLink,
  'version': instance.version,
  'status': instance.status,
  'categories': instance.categories,
  'images': instance.images,
  'creator': instance.creator,
};

ModCreator _$ModCreatorFromJson(Map<String, dynamic> json) =>
    ModCreator(name: json['name'] as String, image: json['image'] as String?);

Map<String, dynamic> _$ModCreatorToJson(ModCreator instance) =>
    <String, dynamic>{'name': instance.name, 'image': instance.image};

NamedEntity _$NamedEntityFromJson(Map<String, dynamic> json) =>
    NamedEntity(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$NamedEntityToJson(NamedEntity instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

ImageObject _$ImageObjectFromJson(Map<String, dynamic> json) =>
    ImageObject(id: json['id'] as String?, url: json['url'] as String);

Map<String, dynamic> _$ImageObjectToJson(ImageObject instance) =>
    <String, dynamic>{'id': instance.id, 'url': instance.url};
