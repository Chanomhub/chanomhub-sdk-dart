// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsored_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SponsoredArticle _$SponsoredArticleFromJson(Map<String, dynamic> json) =>
    SponsoredArticle(
      id: (json['id'] as num).toInt(),
      articleId: (json['articleId'] as num).toInt(),
      coverImage: json['coverImage'] as String?,
      isActive: json['isActive'] as bool,
      priority: (json['priority'] as num).toInt(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String?,
      article: ArticleListItem.fromJson(
        json['article'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SponsoredArticleToJson(SponsoredArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'articleId': instance.articleId,
      'coverImage': instance.coverImage,
      'isActive': instance.isActive,
      'priority': instance.priority,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'article': instance.article,
    };
