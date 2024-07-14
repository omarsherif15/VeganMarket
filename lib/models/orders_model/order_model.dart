import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopmart2/models/cartModel/cart_model.dart';
part 'order_model.g.dart';
@JsonSerializable()
class OrderModel with ChangeNotifier{
  String? orderId;
  String? userUid;
  String? orderAddress;
  String? phoneNo;
  String? comment;
  double? totalPrice;
  double? shipping;
  int? totalQuantity;
  List<Map<String, dynamic>>? cartItems;
  String? status;
  String? createdAt;

  OrderModel(
      {
        required this.orderId,
        required this.userUid,
        required this.orderAddress,
        required this.phoneNo,
        required this.shipping,
        required this.comment,
        required this.totalPrice,
        required this.totalQuantity,
        required this.cartItems,
        required this.status,
        required this.createdAt,
      });

  factory OrderModel.fromJson(Map<String, dynamic>? json) => _$OrderModelFromJson(json!);

  Map<String, dynamic> toMap () => _$OrderModelToJson(this);
}