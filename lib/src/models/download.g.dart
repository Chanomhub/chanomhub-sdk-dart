// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadLink _$DownloadLinkFromJson(Map<String, dynamic> json) => DownloadLink(
  id: (json['id'] as num).toInt(),
  articleId: (json['articleId'] as num).toInt(),
  createdById: (json['createdById'] as num?)?.toInt(),
  name: json['name'] as String?,
  url: json['url'] as String,
  isActive: json['isActive'] as bool,
  status: json['status'] as String,
  vipOnly: json['vipOnly'] as bool,
  forVersion: json['forVersion'] as String?,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  createdBy: json['createdBy'] == null
      ? null
      : DownloadLinkCreator.fromJson(json['createdBy'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DownloadLinkToJson(DownloadLink instance) =>
    <String, dynamic>{
      'id': instance.id,
      'articleId': instance.articleId,
      'createdById': instance.createdById,
      'name': instance.name,
      'url': instance.url,
      'isActive': instance.isActive,
      'status': instance.status,
      'vipOnly': instance.vipOnly,
      'forVersion': instance.forVersion,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
    };

DownloadLinkCreator _$DownloadLinkCreatorFromJson(Map<String, dynamic> json) =>
    DownloadLinkCreator(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$DownloadLinkCreatorToJson(
  DownloadLinkCreator instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
