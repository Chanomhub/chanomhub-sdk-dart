import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:chanomhub_flutter/chanomhub_flutter.dart';
import 'package:chanomhub_flutter/src/core/api_client.dart';
import 'package:chanomhub_flutter/src/repositories/articles_repository.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ApiClient apiClient;
  late ArticlesRepository articlesRepository;

  const String baseUrl = 'https://api.chanomhub.com';
  const String cdnUrl = 'https://imgproxy.chanomhub.com';

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    dioAdapter = DioAdapter(dio: dio);
    apiClient = ApiClient(
      baseUrl: baseUrl,
      cdnUrl: cdnUrl,
      dioOverride: dio,
    );
    articlesRepository = ArticlesRepository(apiClient);
  });

  group('ArticlesRepository GraphQL Tests', () {
    test('getAllPaginated should fetch and transform articles', () async {
      dioAdapter.onPost(
        '/api/v2/graphql',
        (server) => server.reply(200, {
          'data': {
            'public': {
              'articles': [
                {
                  'id': 1,
                  'title': 'Test Article',
                  'slug': 'test-article',
                  'description': 'Test description',
                  'mainImage': 'test-image.jpg',
                  'favoritesCount': 10,
                  'createdAt': '2024-01-01',
                  'updatedAt': '2024-01-01',
                  'author': {'name': 'Admin', 'image': 'admin.jpg'},
                }
              ],
              'articlesCount': 1,
            }
          }
        }),
        data: Matchers.any,
      );

      final result = await articlesRepository.getAllPaginated(
        options: ArticleListOptions(limit: 10),
      );

      expect(result.items.length, 1);
      expect(result.total, 1);
      expect(result.items.first.title, 'Test Article');
      expect(
        result.items.first.mainImage,
        contains('imgproxy.chanomhub.com/insecure/'),
      );
    });

    test('getBySlug should return null when article not found', () async {
      dioAdapter.onPost(
        '/api/v2/graphql',
        (server) => server.reply(200, {
          'data': {
            'public': {'article': null}
          }
        }),
        data: Matchers.any,
      );

      final result = await articlesRepository.getBySlug('non-existent');
      expect(result, isNull);
    });

    test('should throw ChanomhubException on GraphQL errors', () async {
      dioAdapter.onPost(
        '/api/v2/graphql',
        (server) => server.reply(200, {
          'errors': [
            {'message': 'Something went wrong on the server'}
          ]
        }),
        data: Matchers.any,
      );

      expect(
        () => articlesRepository.getTags(),
        throwsA(isA<ChanomhubException>()),
      );
    });
   group('Image URL Transformation Tests', () {
    test('resolveImageUrl should wrap filename in imgproxy URL', () {
      final url = resolveImageUrl('image.jpg', cdnUrl);
      expect(url, equals('https://imgproxy.chanomhub.com/insecure/plain/https%3A%2F%2Fcdn.chanomhub.com%2Fimage.jpg@webp'));
    });

    test('resolveImageUrl should return full URL as-is', () {
      const fullUrl = 'https://example.com/photo.png';
      final url = resolveImageUrl(fullUrl, cdnUrl);
      expect(url, equals(fullUrl));
    });
  });
  });
}
