import 'package:json_annotation/json_annotation.dart';

part 'download.g.dart';

@JsonSerializable()
class DownloadLink {
  final int id;
  final int articleId;
  final int? createdById;
  final String? name;
  final String url;
  final bool isActive;
  final String status;
  final bool vipOnly;
  final String? forVersion;
  final String createdAt;
  final String updatedAt;
  final DownloadLinkCreator? createdBy;

  DownloadLink({
    required this.id,
    required this.articleId,
    this.createdById,
    this.name,
    required this.url,
    required this.isActive,
    required this.status,
    required this.vipOnly,
    this.forVersion,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
  });

  factory DownloadLink.fromJson(Map<String, dynamic> json) =>
      _$DownloadLinkFromJson(json);
  Map<String, dynamic> toJson() => _$DownloadLinkToJson(this);
}

@JsonSerializable()
class DownloadLinkCreator {
  final int id;
  final String name;

  DownloadLinkCreator({required this.id, required this.name});

  factory DownloadLinkCreator.fromJson(Map<String, dynamic> json) =>
      _$DownloadLinkCreatorFromJson(json);
  Map<String, dynamic> toJson() => _$DownloadLinkCreatorToJson(this);
}
