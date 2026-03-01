import '../core/api_client.dart';
import '../models/subscription.dart';

/// Repository for handling Subscriptions and Plans API calls.
class SubscriptionsRepository {
  final ApiClient _apiClient;

  SubscriptionsRepository(this._apiClient);

  /// Create a new subscription
  Future<Subscription?> create(Map<String, dynamic> data) async {
    final response = await _apiClient.dio.post('/api/subscriptions', data: data);
    if (response.data == null) return null;
    return Subscription.fromJson(response.data as Map<String, dynamic>);
  }

  /// Get all user subscriptions
  Future<List<Subscription>> getAll() async {
    final response = await _apiClient.dio.get('/api/subscriptions');
    if (response.data == null) return [];
    final List list = response.data as List;
    return list.map((e) => Subscription.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Cancel a subscription
  Future<Subscription?> cancel(int id) async {
    final response = await _apiClient.dio.delete('/api/subscriptions/$id');
    if (response.data == null) return null;
    return Subscription.fromJson(response.data as Map<String, dynamic>);
  }

  /// Create a new subscription plan (Admin only)
  Future<SubscriptionPlan?> createPlan(Map<String, dynamic> data) async {
    final response = await _apiClient.dio.post('/api/subscriptions/plans', data: data);
    if (response.data == null) return null;
    return SubscriptionPlan.fromJson(response.data as Map<String, dynamic>);
  }

  /// Get all available subscription plans
  Future<List<SubscriptionPlan>> getPlans({bool refresh = false}) async {
    final url = refresh ? '/api/subscriptions/plans?refresh=true' : '/api/subscriptions/plans';
    final response = await _apiClient.dio.get(url);
    if (response.data == null) return [];
    final List list = response.data as List;
    return list.map((e) => SubscriptionPlan.fromJson(e as Map<String, dynamic>)).toList();
  }
}
