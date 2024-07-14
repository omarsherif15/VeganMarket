// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      discountedPercentage: json['discountedPercentage'] as String,
      scale: json['scale'] as String,
      stock: (json['stock'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      productCategoryName: json['productCategoryName'] as String,
      price: (json['price'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      isOnSale: json['isOnSale'] as bool,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'productCategoryName': instance.productCategoryName,
      'description': instance.description,
      'scale': instance.scale,
      'discountedPercentage': instance.discountedPercentage,
      'price': instance.price,
      'salePrice': instance.salePrice,
      'stock': instance.stock,
      'isOnSale': instance.isOnSale,
    };
