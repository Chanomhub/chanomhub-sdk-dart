import 'package:json_annotation/json_annotation.dart';
import 'article.dart';

part 'sponsored_article.g.dart';

@JsonSerializable()
class SponsoredArticle {
  final int id;
  final int articleId;
  final String? coverImage;
  final bool isActive;
  final int priority;
  final String startDate;
  final String? endDate;
  final ArticleListItem article;

  SponsoredArticle({
    required this.id,
    required this.articleId,
    this.coverImage,
    required this.isActive,
    required this.priority,
    required this.startDate,
    this.endDate,
    required this.article,
  });

  factory SponsoredArticle.fromJson(Map<String, dynamic> json) =>
      _$SponsoredArticleFromJson(json);
  Map<String, dynamic> toJson() => _$SponsoredArticleToJson(this);
}
