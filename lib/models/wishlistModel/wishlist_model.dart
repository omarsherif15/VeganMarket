import 'package:flutter/cupertino.dart';

import 'package:json_annotation/json_annotation.dart';


part 'wishlist_model.g.dart';
@JsonSerializable()
class WishlistModel with ChangeNotifier{
  String productId;

  WishlistModel({
    required this.productId,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => _$WishlistModelFromJson(json);

  Map<String, dynamic> toMap () => _$WishlistModelToJson(this);
}