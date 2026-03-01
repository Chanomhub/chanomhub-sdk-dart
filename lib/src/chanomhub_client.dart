import 'package:dio/dio.dart';
import 'core/api_client.dart';
import 'repositories/articles_repository.dart';
import 'repositories/auth_repository.dart';
import 'repositories/downloads_repository.dart';
import 'repositories/favorites_repository.dart';
import 'repositories/mods_repository.dart';
import 'repositories/search_repository.dart';
import 'repositories/sponsored_articles_repository.dart';
import 'repositories/subscriptions_repository.dart';
import 'repositories/users_repository.dart';

/// The main entry point for the Chanomhub SDK.
///
/// Use this class to interact with the Chanomhub API.
class ChanomhubClient {
  /// The underlying API client handling all HTTP requests.
  final ApiClient _apiClient;

  /// Access authentication methods like login, register, and token management.
  late final AuthRepository auth;

  /// Access article methods like fetching, and management.
  late final ArticlesRepository articles;

  /// Access user and profile methods.
  late final UsersRepository users;

  /// Access favorite methods.
  late final FavoritesRepository favorites;

  /// Access search methods.
  late final SearchRepository search;

  /// Access download methods.
  late final DownloadsRepository downloads;

  /// Access subscription methods.
  late final SubscriptionsRepository subscriptions;

  /// Access mod methods.
  late final ModsRepository mods;

  /// Access sponsored article methods.
  late final SponsoredArticlesRepository sponsoredArticles;

  /// Creates a new instance of [ChanomhubClient].
  ///
  /// [baseUrl] is the root URL for the Chanomhub API.
  /// [cdnUrl] is the imgproxy base URL for image processing.
  /// [storageUrl] is the original storage base URL (source images).
  /// You can optionally provide your own [Dio] instance via [dioOverride] for advanced customization.
  ChanomhubClient({
    required String baseUrl,
    required String cdnUrl,
    String storageUrl = 'https://cdn.chanomhub.com',
    String? token,
    Dio? dioOverride,
  }) : _apiClient = ApiClient(
         baseUrl: baseUrl,
         cdnUrl: cdnUrl,
         storageUrl: storageUrl,
         dioOverride: dioOverride,
       ) {
    if (token != null) {
      _apiClient.dio.options.headers['Authorization'] = 'Bearer $token';
    }
    auth = AuthRepository(_apiClient);
    articles = ArticlesRepository(_apiClient);
    users = UsersRepository(_apiClient);
    favorites = FavoritesRepository(_apiClient);
    search = SearchRepository(_apiClient);
    downloads = DownloadsRepository(_apiClient);
    subscriptions = SubscriptionsRepository(_apiClient);
    mods = ModsRepository(_apiClient);
    sponsoredArticles = SponsoredArticlesRepository(_apiClient);
  }

  /// Grants access to the underlying Dio client, mainly for adding custom interceptors
  /// such as authentication token injectors if not using the built-in [AuthModule].
  Dio get dio => _apiClient.dio;

  /// Disposes the client and closes underlying HTTP connections.
  void dispose({bool force = false}) {
    _apiClient.dio.close(force: force);
  }
}
