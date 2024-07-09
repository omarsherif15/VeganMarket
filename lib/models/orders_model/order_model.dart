import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopmart2/models/cartModel/cart_model.dart';
part 'order_model.g.dart';
@JsonSerializable()
class OrderModel with ChangeNotifier{
  String? orderId;
  String? userUid;
  double? totalPrice;
  int? totalQuantity;
  List<CartModel> cartItems;
  String? status;
  String? createdAt;

  OrderModel(
      {
        required this.orderId,
        required this.userUid,
        required this.totalPrice,
        required this.totalQuantity,
        required this.cartItems,
        required this.status,
        required this.createdAt,
      });

  factory OrderModel.fromJson(Map<String, dynamic>? json) => _$OrderModelFromJson(json!);

  Map<String, dynamic> toMap () => _$OrderModelToJson(this);

}