import 'package:json_annotation/json_annotation.dart';
import 'common.dart';

part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
  @JsonKey(fromJson: toInt)
  final int id;
  @JsonKey(fromJson: toInt)
  final int userId;
  final String planId;
  final String status;
  final String currentPeriodStart;
  final String currentPeriodEnd;
  final bool cancelAtPeriodEnd;
  final String startDate;
  final String? endDate;
  final String createdAt;
  final String updatedAt;

  Subscription({
    required this.id,
    required this.userId,
    required this.planId,
    required this.status,
    required this.currentPeriodStart,
    required this.currentPeriodEnd,
    required this.cancelAtPeriodEnd,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}

@JsonSerializable()
class SubscriptionPlan {
  final String planId;
  final String name;
  final String? description;
  @JsonKey(fromJson: toInt)
  final int pointsCost;
  @JsonKey(fromJson: toInt)
  final int durationDays;
  @JsonKey(fromJson: toInt)
  final int roleId;
  final bool isActive;

  SubscriptionPlan({
    required this.planId,
    required this.name,
    this.description,
    required this.pointsCost,
    required this.durationDays,
    required this.roleId,
    required this.isActive,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionPlanToJson(this);
}
