import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customer_model.g.dart';
@JsonSerializable()
class CustomerModel with ChangeNotifier{
  String? customerUID;
  String? fullName;
  String? emailAddress;
  String? phoneNumber;
  String? imageUrl;
  String? createdAt;
  String? loginType;
  int? totalSpent;
  double currentCartCost;
  int currentCartQuantity;

  CustomerModel(
      {
        required this.customerUID,
        required this.fullName,
        required this.emailAddress,
        required this.phoneNumber,
        required this.imageUrl,
        required this.createdAt,
        required this.loginType,
        required this.totalSpent,
        required this.currentCartCost,
        required this.currentCartQuantity
      });

  factory CustomerModel.fromJson(Map<String, dynamic>? json) => _$CustomerModelFromJson(json!);

  Map<String, dynamic> toMap () => _$CustomerModelToJson(this);

}