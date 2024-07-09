// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      orderId: json['orderId'] as String?,
      userUid: json['userUid'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      totalQuantity: (json['totalQuantity'] as num?)?.toInt(),
      cartItems: (json['cartItems'] as List<dynamic>)
          .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'userUid': instance.userUid,
      'totalPrice': instance.totalPrice,
      'totalQuantity': instance.totalQuantity,
      'cartItems': instance.cartItems,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
