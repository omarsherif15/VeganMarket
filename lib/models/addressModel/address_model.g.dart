// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingAddress _$ShippingAddressFromJson(Map<String, dynamic> json) =>
    ShippingAddress(
      shippingAddressID: json['shippingAddressID'] as String?,
      name: json['name'] as String?,
      houseNo: json['houseNo'] as String?,
      phoneNo: json['phoneNo'] as String?,
      streetAddress: json['streetAddress'] as String?,
      cityName: json['cityName'] as String?,
      countryName: json['countryName'] as String?,
      postCode: json['postCode'] as String?,
    );

Map<String, dynamic> _$ShippingAddressToJson(ShippingAddress instance) =>
    <String, dynamic>{
      'shippingAddressID': instance.shippingAddressID,
      'name': instance.name,
      'houseNo': instance.houseNo,
      'phoneNo': instance.phoneNo,
      'streetAddress': instance.streetAddress,
      'cityName': instance.cityName,
      'countryName': instance.countryName,
      'postCode': instance.postCode,
    };
