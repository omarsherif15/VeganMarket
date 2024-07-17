import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shopmart2/models/wishlistModel/wishlist_model.dart';
import '../consts/consts.dart';

class WishlistProvider with ChangeNotifier {


  WishlistModel? wishlistModel;
  Future<void> addAndRemoveFromWishlist({
    required String productId,
  }) async {
    DocumentSnapshot? docs;
    WishlistModel wishlistModel = WishlistModel(productId: productId);
    print('55555555555555');
    try {
      docs = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(currentCustomerUID)
          .collection('WishList')
          .doc(productId).get();
      if(docs.exists) {
        await FirebaseFirestore.instance
          .collection('Customers')
          .doc(currentCustomerUID)
          .collection('WishList')
          .doc(productId).delete();
        await toogleWishListButton(productId);
        notifyListeners();
      }
      else {
        await FirebaseFirestore.instance
          .collection('Customers')
          .doc(currentCustomerUID)
          .collection('WishList')
          .doc(productId).set(wishlistModel.toMap());
        await toogleWishListButton(productId);
        notifyListeners();
      }
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }
  Future<void> clearWish() async{
    await FirebaseFirestore.instance.collection('Customers')
        .doc(currentCustomerUID).collection('WishList').get().then((value){
      value.docs.forEach((element){
        FirebaseFirestore.instance.collection('Customers')
            .doc(currentCustomerUID).collection('WishList').doc(element.id).delete();
      });
    });
  }
  Future<bool> toogleWishListButton(productId) async {
    bool inWishList = false;
    await FirebaseFirestore.instance
        .collection('Customers')
        .doc(currentCustomerUID)
        .collection('WishList')
        .get()
        .then((onValue) {
      onValue.docs.forEach((element) {
        if (element.id == productId) {
          inWishList = true;
        }
      });
    });
    return inWishList;
  }
}
