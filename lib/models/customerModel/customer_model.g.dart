// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      customerUID: json['customerUID'] as String?,
      fullName: json['fullName'] as String?,
      defaultShippingAddress: json['defaultShippingAddress'] as String?,
      emailAddress: json['emailAddress'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      loginType: json['loginType'] as String?,
      totalSpent: (json['totalSpent'] as num?)?.toInt(),
      currentCartCost: (json['currentCartCost'] as num).toDouble(),
      currentCartQuantity: (json['currentCartQuantity'] as num).toInt(),
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'customerUID': instance.customerUID,
      'fullName': instance.fullName,
      'emailAddress': instance.emailAddress,
      'phoneNumber': instance.phoneNumber,
      'imageUrl': instance.imageUrl,
      'defaultShippingAddress': instance.defaultShippingAddress,
      'createdAt': instance.createdAt,
      'loginType': instance.loginType,
      'totalSpent': instance.totalSpent,
      'currentCartCost': instance.currentCartCost,
      'currentCartQuantity': instance.currentCartQuantity,
    };
