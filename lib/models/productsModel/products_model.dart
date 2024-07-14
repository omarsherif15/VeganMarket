import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart';
@JsonSerializable()
class ProductModel with ChangeNotifier {
  final String id, title, imageUrl, productCategoryName, description, scale, discountedPercentage;
  final double price, salePrice, stock;
  final bool isOnSale;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.discountedPercentage,
    required this.scale,
    required this.stock,
    required this.imageUrl,
    required this.productCategoryName,
    required this.price,
    required this.salePrice,
    required this.isOnSale,
  });

  factory ProductModel.fromJson(Map<String, dynamic>? json) => _$ProductModelFromJson(json!);

  Map<String, dynamic> toMap () => _$ProductModelToJson(this);
}
