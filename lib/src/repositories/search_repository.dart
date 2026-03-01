import '../core/api_client.dart';
import '../models/article.dart';
import '../models/common.dart';
import '../utils/fields.dart';

/// Search options for articles
class SearchOptions {
  final String? tag;
  final String? platform;
  final String? category;
  final String? engine;
  final String? sequentialCode;
  final String? author;
  final int limit;
  final int offset;
  final ArticlePreset preset;
  final List<String>? fields;

  SearchOptions({
    this.tag,
    this.platform,
    this.category,
    this.engine,
    this.sequentialCode,
    this.author,
    this.limit = 12,
    this.offset = 0,
    this.preset = ArticlePreset.standard,
    this.fields,
  });
}

/// Repository for handling Search API calls.
class SearchRepository {
  final ApiClient _apiClient;

  SearchRepository(this._apiClient);

  /// Search articles by query string
  Future<PaginatedResponse<ArticleListItem>> articles(
    String query, {
    SearchOptions? options,
  }) async {
    final opts = options ?? SearchOptions();
    final fieldsQuery = buildFieldsQuery(preset: opts.preset, fields: opts.fields);

    final List<String> filterParts = [];
    filterParts.add('q: "\${query.replaceAll('"', '\\"')}"');
    if (opts.tag != null) filterParts.add('tag: "\${opts.tag}"');
    if (opts.platform != null) filterParts.add('platform: "\${opts.platform}"');
    if (opts.category != null) filterParts.add('category: "\${opts.category}"');
    if (opts.engine != null) filterParts.add('engine: "\${opts.engine}"');
    if (opts.sequentialCode != null) {
      filterParts.add('sequentialCode: "\${opts.sequentialCode}"');
    }
    if (opts.author != null) filterParts.add('author: "\${opts.author}"');

    final filterArg = "filter: { \${filterParts.join(', ')} }";

    final graphqlQuery = '''
      query SearchArticles {
        public {
          articles(\$filterArg, limit: \${opts.limit}, offset: \${opts.offset}, status: PUBLISHED) {
            \$fieldsQuery
          }
          articlesCount(\$filterArg)
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      graphqlQuery,
      operationName: 'SearchArticles',
    );

    final publicData = response?['public'] ?? {};
    final List articlesList = publicData['articles'] ?? [];
    final int articlesCount = toInt(publicData['articlesCount']);

    final items = articlesList
        .map((e) => ArticleListItem.fromJson(e as Map<String, dynamic>))
        .toList();

    final page = (opts.offset / opts.limit).floor() + 1;

    return PaginatedResponse<ArticleListItem>(
      items: items,
      total: articlesCount,
      page: page,
      pageSize: opts.limit,
    );
  }
}
