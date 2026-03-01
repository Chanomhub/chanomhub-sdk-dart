/// Chanomhub SDK - Shared Field Query Utilities
/// Used by articleRepository and searchRepository

enum ArticlePreset { minimal, standard, full, complete }

const Map<ArticlePreset, List<String>> fieldPresets = {
  ArticlePreset.minimal: ['id', 'title', 'slug', 'mainImage'],
  ArticlePreset.standard: [
    'id',
    'title',
    'slug',
    'description',
    'ver',
    'mainImage',
    'coverImage',
    'author',
    'tags',
    'platforms',
    'categories',
    'creators',
    'engine',
    'favoritesCount',
    'favorited',
    'createdAt',
    'updatedAt',
    'status',
    'sequentialCode',
    'images',
  ],
  ArticlePreset.full: [
    'id',
    'title',
    'slug',
    'description',
    'body',
    'ver',
    'mainImage',
    'coverImage',
    'backgroundImage',
    'author',
    'tags',
    'platforms',
    'categories',
    'creators',
    'engine',
    'images',
    'favoritesCount',
    'favorited',
    'createdAt',
    'updatedAt',
    'status',
    'sequentialCode',
  ],
  ArticlePreset.complete: [
    'id',
    'title',
    'slug',
    'description',
    'body',
    'ver',
    'mainImage',
    'coverImage',
    'backgroundImage',
    'author',
    'tags',
    'platforms',
    'categories',
    'creators',
    'engine',
    'images',
    'favoritesCount',
    'favorited',
    'createdAt',
    'updatedAt',
    'status',
    'sequentialCode',
    'downloads',
    'mods',
    'officialDownloadSources',
    'versions',
  ],
};

const Map<String, String> fieldMappings = {
  'id': 'id',
  'title': 'title',
  'slug': 'slug',
  'description': 'description',
  'body': 'body',
  'ver': 'ver',
  'mainImage': 'mainImage',
  'coverImage': 'coverImage',
  'backgroundImage': 'backgroundImage',
  'createdAt': 'createdAt',
  'updatedAt': 'updatedAt',
  'status': 'status',
  'sequentialCode': 'sequentialCode',
  'favoritesCount': 'favoritesCount',
  'favorited': 'favorited',
  'engine': '''engine {
    id
    name
  }''',
  'author': '''author {
    id
    name
    image
  }''',
  'creators': '''creators {
    id
    name
  }''',
  'tags': '''tags {
    id
    name
  }''',
  'platforms': '''platforms {
    id
    name
  }''',
  'categories': '''categories {
    id
    name
  }''',
  'images': '''images {
    id
    url
  }''',
  'mods': '''mods {
    id
    name
    version
    downloadLink
    description
    creditTo
    status
    categories {
      id
      name
    }
    images {
      id
      url
    }
  }''',
  'versions': 'versions',
  'downloads': '''downloads {
    id
    name
    url
    isActive
    vipOnly
    forVersion
    createdAt
    updatedAt
  }''',
  'downloadLinks': '''downloads {
    id
    url
    vipOnly
  }''',
  'officialDownloadSources': '''officialDownloadSources {
    id
    name
    url
    status
  }''',
  'version': 'version',
};

class FieldQueryOptions {
  final ArticlePreset preset;
  final List<String>? fields;

  const FieldQueryOptions({
    this.preset = ArticlePreset.standard,
    this.fields,
  });
}

/// Builds GraphQL fields query from preset or custom fields
String buildFieldsQuery({
  ArticlePreset preset = ArticlePreset.standard,
  List<String>? fields,
}) {
  final selectedFields = fields ?? fieldPresets[preset]!;

  return selectedFields
      .map((field) => fieldMappings[field])
      .where((field) => field != null)
      .join('\n  ');
}

const Map<String, String> fieldMappingsMod = {
  'id': 'id',
  'name': 'name',
  'description': 'description',
  'creditTo': 'creditTo',
  'downloadLink': 'downloadLink',
  'version': 'version',
  'status': 'status',
  'categories': '''categories {
    id
    name
  }''',
  'images': '''images {
    id
    url
  }''',
  'creator': '''creator {
    name
    image
  }''',
};

/// Builds GraphQL mod fields query
String buildModFieldsQuery({List<String>? fields}) {
  final defaultFields = ['id', 'name', 'version', 'downloadLink'];

  final selectedFields = fields ?? defaultFields;

  return selectedFields
      .map((field) => fieldMappingsMod[field])
      .where((field) => field != null)
      .join('\n  ');
}
