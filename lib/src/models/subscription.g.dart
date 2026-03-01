// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  planId: json['planId'] as String,
  status: json['status'] as String,
  currentPeriodStart: json['currentPeriodStart'] as String,
  currentPeriodEnd: json['currentPeriodEnd'] as String,
  cancelAtPeriodEnd: json['cancelAtPeriodEnd'] as bool,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String?,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'planId': instance.planId,
      'status': instance.status,
      'currentPeriodStart': instance.currentPeriodStart,
      'currentPeriodEnd': instance.currentPeriodEnd,
      'cancelAtPeriodEnd': instance.cancelAtPeriodEnd,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) =>
    SubscriptionPlan(
      planId: json['planId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      pointsCost: (json['pointsCost'] as num).toInt(),
      durationDays: (json['durationDays'] as num).toInt(),
      roleId: (json['roleId'] as num).toInt(),
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$SubscriptionPlanToJson(SubscriptionPlan instance) =>
    <String, dynamic>{
      'planId': instance.planId,
      'name': instance.name,
      'description': instance.description,
      'pointsCost': instance.pointsCost,
      'durationDays': instance.durationDays,
      'roleId': instance.roleId,
      'isActive': instance.isActive,
    };
