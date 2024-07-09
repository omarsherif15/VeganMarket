import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_model.g.dart';

@JsonSerializable()
class CartModel with ChangeNotifier{
  String? productId;
  int? quantity;

  CartModel({
    required this.productId,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);

  Map<String, dynamic> toMap () => _$CartModelToJson(this);
}
