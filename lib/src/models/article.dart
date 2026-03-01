import 'package:json_annotation/json_annotation.dart';
import 'common.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  @JsonKey(fromJson: toInt)
  final int id;
  final String title;
  final String slug;
  final String description;
  final String body;
  final String? ver;
  final List<NamedEntity> creators;
  final List<NamedEntity> tags;
  final List<NamedEntity> platforms;
  final List<NamedEntity> categories;
  final String createdAt;
  final String updatedAt;
  final String status;
  final Engine engine;
  final String? mainImage;
  final String? backgroundImage;
  final String? coverImage;
  final List<ImageObject> images;
  final Author author;
  final bool favorited;
  @JsonKey(fromJson: toInt)
  final int favoritesCount;
  final String? sequentialCode;
  final List<Download>? downloads;
  final List<Mod> mods;
  final List<String>? versions;
  final List<Download>? downloadLinks;
  final List<OfficialDownloadSource>? officialDownloadSources;
  final String? version;

  Article({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.body,
    this.ver,
    required this.creators,
    required this.tags,
    required this.platforms,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.engine,
    this.mainImage,
    this.backgroundImage,
    this.coverImage,
    required this.images,
    required this.author,
    required this.favorited,
    required this.favoritesCount,
    this.sequentialCode,
    this.downloads,
    required this.mods,
    this.versions,
    this.downloadLinks,
    this.officialDownloadSources,
    this.version,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class ArticleListItem {
  @JsonKey(fromJson: toInt)
  final int id;
  final String title;
  final String slug;
  final String description;
  final String? ver;
  final String createdAt;
  final String updatedAt;
  final String? mainImage;
  final String? coverImage;
  @JsonKey(fromJson: toInt)
  final int favoritesCount;
  final bool? favorited;
  final String? status;
  final Engine? engine;
  final String? sequentialCode;
  final Author author;
  final List<NamedEntity>? tags;
  final List<NamedEntity>? platforms;
  final List<NamedEntity>? categories;
  final List<NamedEntity>? creators;
  final List<ImageObject>? images;

  ArticleListItem({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    this.ver,
    required this.createdAt,
    required this.updatedAt,
    this.mainImage,
    this.coverImage,
    required this.favoritesCount,
    this.favorited,
    this.status,
    this.engine,
    this.sequentialCode,
    required this.author,
    this.tags,
    this.platforms,
    this.categories,
    this.creators,
    this.images,
  });

  factory ArticleListItem.fromJson(Map<String, dynamic> json) =>
      _$ArticleListItemFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleListItemToJson(this);
}

@JsonSerializable()
class Engine {
  final String id;
  final String name;

  Engine({required this.id, required this.name});

  factory Engine.fromJson(Map<String, dynamic> json) => _$EngineFromJson(json);
  Map<String, dynamic> toJson() => _$EngineToJson(this);
}

@JsonSerializable()
class ArticleWithDownloads {
  final Article? article;
  final List<Download>? downloads;

  ArticleWithDownloads({this.article, this.downloads});

  factory ArticleWithDownloads.fromJson(Map<String, dynamic> json) =>
      _$ArticleWithDownloadsFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleWithDownloadsToJson(this);
}
