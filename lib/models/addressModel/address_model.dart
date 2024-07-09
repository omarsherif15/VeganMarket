import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';
@JsonSerializable()
class ShippingAddress {
  String? name;
  String? streetAddress;
  String? cityName;
  String? countryName;
  String? postCode;

  ShippingAddress({
    required this.name,
    required this.streetAddress,
    required this.cityName,
    required this.countryName,
    required this.postCode,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => _$ShippingAddressFromJson(json);

  Map<String, dynamic> toMap () => _$ShippingAddressToJson(this);
}