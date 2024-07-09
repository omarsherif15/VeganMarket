import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopmart2/models/wishlistModel/wishlist_model.dart';
import '../consts/consts.dart';

class WishlistProvider with ChangeNotifier {


  WishlistModel? wishlistModel;
  void addAndRemoveFromWishlist({
    required String productId,
  }) async {
    WishlistModel wishlistModel = WishlistModel(productId: productId);
    await getWishListItems(currentCustomerUID);
    if(wishListItems.contains(wishlistModel)) {
      try {
        FirebaseFirestore.instance
            .collection('Customers')
            .doc(currentCustomerUID)
            .collection('WishList')
            .doc(productId)
            .set(wishlistModel.toMap());
      } on FirebaseException catch (error) {
        print(error.message);
      }
    }
    else{
      try {
        FirebaseFirestore.instance
            .collection('Customers')
            .doc(currentCustomerUID)
            .collection('WishList')
            .doc(productId)
            .delete();
      } on FirebaseException catch (error) {
        print(error.message);
      }
    }
  }
  List<WishlistModel> wishListItems = [];
  Future<void> getWishListItems (customerId)async{
    await FirebaseFirestore.instance.collection('Customers').doc(
        currentCustomerUID).collection('WishList').get().then((value){
          wishListItems = [];
      for (var element in value.docs) {
        wishListItems.add(WishlistModel.fromJson(element.data()));
      }
    });
  }
  Future<void> removeFromWish({
    required String productId,
  }) async{
    await FirebaseFirestore.instance.collection('Customers')
        .doc(currentCustomerUID).collection('WishList').doc(productId)
        .delete();
    notifyListeners();
  }

  Future<void> clearWish() async{
    wishListItems = [];
    await FirebaseFirestore.instance.collection('Customers')
        .doc(currentCustomerUID).collection('WishList')
        .doc().delete();
    notifyListeners();
  }
}
