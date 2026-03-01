// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  slug: json['slug'] as String,
  description: json['description'] as String,
  body: json['body'] as String,
  ver: json['ver'] as String?,
  creators: (json['creators'] as List<dynamic>)
      .map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  tags: (json['tags'] as List<dynamic>)
      .map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  platforms: (json['platforms'] as List<dynamic>)
      .map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  categories: (json['categories'] as List<dynamic>)
      .map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  status: json['status'] as String,
  engine: Engine.fromJson(json['engine'] as Map<String, dynamic>),
  mainImage: json['mainImage'] as String?,
  backgroundImage: json['backgroundImage'] as String?,
  coverImage: json['coverImage'] as String?,
  images: (json['images'] as List<dynamic>)
      .map((e) => ImageObject.fromJson(e as Map<String, dynamic>))
      .toList(),
  author: Author.fromJson(json['author'] as Map<String, dynamic>),
  favorited: json['favorited'] as bool,
  favoritesCount: (json['favoritesCount'] as num).toInt(),
  sequentialCode: json['sequentialCode'] as String?,
  downloads: (json['downloads'] as List<dynamic>?)
      ?.map((e) => Download.fromJson(e as Map<String, dynamic>))
      .toList(),
  mods: (json['mods'] as List<dynamic>)
      .map((e) => Mod.fromJson(e as Map<String, dynamic>))
      .toList(),
  versions: (json['versions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  downloadLinks: (json['downloadLinks'] as List<dynamic>?)
      ?.map((e) => Download.fromJson(e as Map<String, dynamic>))
      .toList(),
  officialDownloadSources: (json['officialDownloadSources'] as List<dynamic>?)
      ?.map((e) => OfficialDownloadSource.fromJson(e as Map<String, dynamic>))
      .toList(),
  version: json['version'] as String?,
);

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'description': instance.description,
  'body': instance.body,
  'ver': instance.ver,
  'creators': instance.creators,
  'tags': instance.tags,
  'platforms': instance.platforms,
  'categories': instance.categories,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'status': instance.status,
  'engine': instance.engine,
  'mainImage': instance.mainImage,
  'backgroundImage': instance.backgroundImage,
  'coverImage': instance.coverImage,
  'images': instance.images,
  'author': instance.author,
  'favorited': instance.favorited,
  'favoritesCount': instance.favoritesCount,
  'sequentialCode': instance.sequentialCode,
  'downloads': instance.downloads,
  'mods': instance.mods,
  'versions': instance.versions,
  'downloadLinks': instance.downloadLinks,
  'officialDownloadSources': instance.officialDownloadSources,
  'version': instance.version,
};

ArticleListItem _$ArticleListItemFromJson(Map<String, dynamic> json) =>
    ArticleListItem(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      ver: json['ver'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      mainImage: json['mainImage'] as String?,
      coverImage: json['coverImage'] as String?,
      favoritesCount: (json['favoritesCount'] as num).toInt(),
      favorited: json['favorited'] as bool?,
      status: json['status'] as String?,
      engine: json['engine'] == null
          ? null
          : Engine.fromJson(json['engine'] as Map<String, dynamic>),
      sequentialCode: json['sequentialCode'] as String?,
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      platforms: (json['platforms'] as List<dynamic>?)
          ?.map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      creators: (json['creators'] as List<dynamic>?)
          ?.map((e) => NamedEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleListItemToJson(ArticleListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'ver': instance.ver,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'mainImage': instance.mainImage,
      'coverImage': instance.coverImage,
      'favoritesCount': instance.favoritesCount,
      'favorited': instance.favorited,
      'status': instance.status,
      'engine': instance.engine,
      'sequentialCode': instance.sequentialCode,
      'author': instance.author,
      'tags': instance.tags,
      'platforms': instance.platforms,
      'categories': instance.categories,
      'creators': instance.creators,
      'images': instance.images,
    };

Engine _$EngineFromJson(Map<String, dynamic> json) =>
    Engine(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$EngineToJson(Engine instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

ArticleWithDownloads _$ArticleWithDownloadsFromJson(
  Map<String, dynamic> json,
) => ArticleWithDownloads(
  article: json['article'] == null
      ? null
      : Article.fromJson(json['article'] as Map<String, dynamic>),
  downloads: (json['downloads'] as List<dynamic>?)
      ?.map((e) => Download.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ArticleWithDownloadsToJson(
  ArticleWithDownloads instance,
) => <String, dynamic>{
  'article': instance.article,
  'downloads': instance.downloads,
};
