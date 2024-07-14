import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopmart2/models/addressModel/address_model.dart';

import '../consts/consts.dart';

class AddressProvider with ChangeNotifier{

  bool shippingAddressLoading = false;
  Future<void> addShippingAddress ({
    required String shippingAddressID,
    required String name,
    required String houseNo,
    required String phoneNo,
    required String streetAddress,
    required String cityName,
    required String countryName,
    required String postCode,

  })async{
    shippingAddressLoading = true;
    notifyListeners();
    ShippingAddress shippingAddress = ShippingAddress(
        shippingAddressID: shippingAddressID,
        name: name,
        houseNo: houseNo,
        phoneNo: phoneNo,
        streetAddress: streetAddress,
        cityName: cityName,
        countryName: countryName,
        postCode: postCode
    );
    await FirebaseFirestore.instance.collection('Customers')
        .doc(currentCustomerUID)
        .collection('ShippingAddress')
        .doc(shippingAddressID)
        .set(shippingAddress.toMap());
    shippingAddressLoading = false;
    notifyListeners();
  }

  Future<void> deleteShippingAddress(shippingAddressID) async {
    await FirebaseFirestore.instance.collection('Customers')
        .doc(currentCustomerUID)
        .collection('ShippingAddress')
        .doc(shippingAddressID).delete();
  }

}