import '../core/api_client.dart';
import '../models/article.dart';
import '../models/common.dart';
import '../utils/fields.dart';
import '../utils/parsers.dart';

class ArticleFilter {
  final String? tag;
  final String? platform;
  final String? category;
  final String? author;
  final bool? favorited;
  final String? engine;
  final String? sequentialCode;
  final String? query; // Renamed from q for better DX

  ArticleFilter({
    this.tag,
    this.platform,
    this.category,
    this.author,
    this.favorited,
    this.engine,
    this.sequentialCode,
    this.query,
  });
}

class ArticleListOptions {
  final int limit;
  final int offset;
  final String status;
  final ArticleFilter? filter;
  final ArticlePreset preset;
  final List<String>? fields;

  ArticleListOptions({
    this.limit = 12,
    this.offset = 0,
    this.status = 'PUBLISHED',
    this.filter,
    this.preset = ArticlePreset.standard,
    this.fields,
  });
}

class ArticleQueryOptions {
  final String? language;
  final String? version;
  final ArticlePreset preset;
  final List<String>? fields;
  final int limit;
  final int offset;

  ArticleQueryOptions({
    this.language,
    this.version,
    this.preset = ArticlePreset.full,
    this.fields,
    this.limit = 50,
    this.offset = 0,
  });
}

/// Repository for handling Article API calls via GraphQL and REST.
class ArticlesRepository {
  final ApiClient _apiClient;

  ArticlesRepository(this._apiClient);

  String _buildFilterArg(ArticleFilter? filter) {
    if (filter == null) return '';

    final List<String> parts = [];
    if (filter.tag != null) parts.add('tag: "${filter.tag}"');
    if (filter.platform != null) parts.add('platform: "${filter.platform}"');
    if (filter.category != null) parts.add('category: "${filter.category}"');
    if (filter.author != null) parts.add('author: "${filter.author}"');
    if (filter.favorited != null) parts.add('favorited: ${filter.favorited}');
    if (filter.engine != null) parts.add('engine: "${filter.engine}"');
    if (filter.sequentialCode != null) {
      parts.add('sequentialCode: "${filter.sequentialCode}"');
    }
    if (filter.query != null) {
      parts.add('q: "${filter.query!.replaceAll('"', '\\"')}"');
    }

    if (parts.isEmpty) return '';
    return "filter: { ${parts.join(', ')} }, ";
  }

  /// Get list of articles
  Future<List<ArticleListItem>> getAll({ArticleListOptions? options}) async {
    final opts = options ?? ArticleListOptions();
    final filterArg = _buildFilterArg(opts.filter);
    final fieldsQuery = buildFieldsQuery(preset: opts.preset, fields: opts.fields);

    final query = '''
      query GetArticles {
        public {
          articles(${filterArg}limit: ${opts.limit}, offset: ${opts.offset}, status: ${opts.status}) {
            $fieldsQuery
          }
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      operationName: 'GetArticles',
    );

    final List articlesList = response?['public']?['articles'] ?? [];
    return articlesList
        .map((e) => ArticleListItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get paginated list of articles with total count
  Future<PaginatedResponse<ArticleListItem>> getAllPaginated({
    ArticleListOptions? options,
  }) async {
    final opts = options ?? ArticleListOptions();
    final filterArg = _buildFilterArg(opts.filter);
    
    String countFilterArg = '';
    if (opts.filter != null) {
        final f = _buildFilterArg(opts.filter);
        if (f.isNotEmpty) {
            countFilterArg = '(${f.substring(0, f.length - 2)})'; // Remove trailing ', '
        }
    }
    
    final fieldsQuery = buildFieldsQuery(preset: opts.preset, fields: opts.fields);

    final query = '''
      query GetArticlesPaginated {
        public {
          articles(${filterArg}limit: ${opts.limit}, offset: ${opts.offset}, status: ${opts.status}) {
            $fieldsQuery
          }
          articlesCount$countFilterArg
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      operationName: 'GetArticlesPaginated',
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

  /// Get single article by ID
  Future<Article?> getById(
    int id, {
    ArticleQueryOptions? options,
  }) async {
    final opts = options ?? ArticleQueryOptions();
    final fieldsQuery = buildFieldsQuery(preset: opts.preset, fields: opts.fields);

    final query = '''
      query GetArticleById(\$id: Int!) {
        public {
          article(id: \$id) {
            $fieldsQuery
          }
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      variables: {'id': id},
      operationName: 'GetArticleById',
    );

    final articleData = response?['public']?['article'];
    if (articleData == null) return null;
    return Article.fromJson(articleData as Map<String, dynamic>);
  }

  /// Get single article by slug
  Future<Article?> getBySlug(
    String slug, {
    ArticleQueryOptions? options,
  }) async {
    final opts = options ?? ArticleQueryOptions();
    final fieldsQuery = buildFieldsQuery(preset: opts.preset, fields: opts.fields);

    final query = '''
      query GetArticleBySlug(\$slug: String!, \$language: String, \$version: String) {
        public {
          article(slug: \$slug, language: \$language, version: \$version) {
            $fieldsQuery
          }
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      variables: {
        'slug': slug,
        if (opts.language != null) 'language': opts.language,
        if (opts.version != null) 'version': opts.version,
      },
      operationName: 'GetArticleBySlug',
    );

    final articleData = response?['public']?['article'];
    if (articleData == null) return null;
    return Article.fromJson(articleData as Map<String, dynamic>);
  }

  /// Get articles by tag
  Future<List<ArticleListItem>> getByTag(
    String tag, {
    ArticleQueryOptions? options,
  }) async {
    final opts = options ?? ArticleQueryOptions(preset: ArticlePreset.standard);
    final fieldsQuery = buildFieldsQuery(preset: opts.preset, fields: opts.fields);

    final query = '''
      query GetArticlesByTag(\$tag: String!) {
        public {
          articles(filter: { tag: \$tag }, status: PUBLISHED, limit: ${opts.limit}, offset: ${opts.offset}) {
            $fieldsQuery
          }
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      variables: {'tag': tag},
      operationName: 'GetArticlesByTag',
    );

    final List articlesList = response?['public']?['articles'] ?? [];
    return articlesList
        .map((e) => ArticleListItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get articles by platform
  Future<List<ArticleListItem>> getByPlatform(
    String platform, {
    ArticleQueryOptions? options,
  }) async {
    final opts = options ?? ArticleQueryOptions(preset: ArticlePreset.standard);
    final fieldsQuery = buildFieldsQuery(preset: opts.preset, fields: opts.fields);

    final query = '''
      query GetArticlesByPlatform(\$platform: String!) {
        public {
          articles(filter: { platform: \$platform }, status: PUBLISHED, limit: ${opts.limit}, offset: ${opts.offset}) {
            $fieldsQuery
          }
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      variables: {'platform': platform},
      operationName: 'GetArticlesByPlatform',
    );

    final List articlesList = response?['public']?['articles'] ?? [];
    return articlesList
        .map((e) => ArticleListItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get articles by category
  Future<List<ArticleListItem>> getByCategory(
    String category, {
    ArticleQueryOptions? options,
  }) async {
    final opts = options ?? ArticleQueryOptions(preset: ArticlePreset.standard);
    final fieldsQuery = buildFieldsQuery(preset: opts.preset, fields: opts.fields);

    final query = '''
      query GetArticlesByCategory(\$category: String!) {
        public {
          articles(filter: { category: \$category }, status: PUBLISHED, limit: ${opts.limit}, offset: ${opts.offset}) {
            $fieldsQuery
          }
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      variables: {'category': category},
      operationName: 'GetArticlesByCategory',
    );

    final List articlesList = response?['public']?['articles'] ?? [];
    return articlesList
        .map((e) => ArticleListItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get article with versions
  Future<Article?> getWithVersions(String slug) async {
    return getBySlug(
      slug,
      options: ArticleQueryOptions(
        fields: ['id', 'title', 'slug', 'versions'],
      ),
    );
  }

  /// Get article by version
  Future<Article?> getByVersion(String slug, String version) async {
    return getBySlug(
      slug,
      options: ArticleQueryOptions(
        version: version,
        fields: ['id', 'title', 'downloadLinks', 'mods'],
      ),
    );
  }

  /// Get mods for an article
  Future<List<Mod>> getMods(int articleId, {List<String>? fields}) async {
    final fieldsQuery = buildModFieldsQuery(fields: fields);

    final query = '''
      query GetArticleMods(\$articleId: Int!) {
        public {
          article(id: \$articleId) {
            mods {
              $fieldsQuery
            }
          }
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      variables: {'articleId': articleId},
      operationName: 'GetArticleMods',
    );

    final List modsList = response?['public']?['article']?['mods'] ?? [];
    return modsList.map((e) => Mod.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Get official download sources for an article
  Future<List<OfficialDownloadSource>> getOfficialDownloadSources(
      int articleId) async {
    final query = '''
      query GetOfficialDownloadSources(\$articleId: Int!) {
        public {
          article(id: \$articleId) {
            officialDownloadSources {
              id
              name
              url
              status
            }
          }
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      variables: {'articleId': articleId},
      operationName: 'GetOfficialDownloadSources',
    );

    final List sourcesList =
        response?['public']?['article']?['officialDownloadSources'] ?? [];
    return sourcesList
        .map((e) => OfficialDownloadSource.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get all available tags
  Future<List<String>> getTags() async {
    final query = '''
      query GetTags {
        system {
          tags
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      operationName: 'GetTags',
    );

    final List tagsList = response?['system']?['tags'] ?? [];
    return tagsList.map((e) => e.toString()).toList();
  }

  /// Get all available categories
  Future<List<String>> getCategories() async {
    final query = '''
      query GetCategories {
        system {
          categories
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      operationName: 'GetCategories',
    );

    final List categoriesList = response?['system']?['categories'] ?? [];
    return categoriesList.map((e) => e.toString()).toList();
  }

  /// Get all available platforms
  Future<List<String>> getPlatforms() async {
    final query = '''
      query GetPlatforms {
        system {
          platforms
        }
      }
    ''';

    final response = await _apiClient.graphqlQuery(
      query,
      operationName: 'GetPlatforms',
    );

    final List platformsList = response?['system']?['platforms'] ?? [];
    return platformsList.map((e) => e.toString()).toList();
  }
}
