// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingAddress _$ShippingAddressFromJson(Map<String, dynamic> json) =>
    ShippingAddress(
      name: json['name'] as String?,
      streetAddress: json['streetAddress'] as String?,
      cityName: json['cityName'] as String?,
      countryName: json['countryName'] as String?,
      postCode: json['postCode'] as String?,
    );

Map<String, dynamic> _$ShippingAddressToJson(ShippingAddress instance) =>
    <String, dynamic>{
      'name': instance.name,
      'streetAddress': instance.streetAddress,
      'cityName': instance.cityName,
      'countryName': instance.countryName,
      'postCode': instance.postCode,
    };
