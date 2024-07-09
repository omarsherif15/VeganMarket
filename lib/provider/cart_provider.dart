import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopmart2/consts/consts.dart';

import '../models/cartModel/cart_model.dart';

class CartProvider with ChangeNotifier{

  List<CartModel> cartItems = [];
  Future<void> getCartItems (customerId)async{
     await FirebaseFirestore.instance.collection('Customers').doc(
        currentCustomerUID).collection('CartList').snapshots().forEach((value){
          cartItems = [];
          for (var element in value.docs) {
            print(element.data()['quantity']);
            cartItems.add(CartModel(productId: element.data()['productId'], quantity: element.data()['quantity']));
          }
          print(cartItems);
    });
  }


  Future<void> addProductsToCart ({
    required String productId,
    required productPrice,
    required int quantity,
  })async{
    CartModel cartModel = CartModel(productId: productId, quantity: quantity);
      await FirebaseFirestore.instance.collection('Customers')
          .doc(currentCustomerUID)
          .collection('CartList')
          .doc(productId)
          .set(cartModel.toMap());
    await FirebaseFirestore.instance.collection('Customers')
        .doc(currentCustomerUID)
        .update({
      'currentCartCost' : FieldValue.increment(productPrice),
      'currentCartQuantity' : FieldValue.increment(quantity),
    });
  }

  //
  Future<void> decreaseQuantityByOne({
    bool edit = false,
    required String productId,
    required double productPrice,
  }) async{
    await FirebaseFirestore.instance.collection('Customers')
        .doc(currentCustomerUID).collection('CartList').doc(productId)
        .update({
          'quantity' : FieldValue.increment(-1)
        });
    if(edit == true){
      await FirebaseFirestore.instance
          .collection('Customers')
          .doc(currentCustomerUID)
          .update({
        'currentCartCost': FieldValue.increment(-productPrice),
        'currentCartQuantity': FieldValue.increment(-1),
      });
    }
    notifyListeners();
  }

  Future<void> increaseQuantityByOne({
    bool edit = false,
    required String productId,
    required double productPrice,
  }) async{
    await FirebaseFirestore.instance.collection('Customers')
        .doc(currentCustomerUID).collection('CartList').doc(productId)
        .update({
      'quantity' : FieldValue.increment(1)
    });
    if(edit == true) {
      await FirebaseFirestore.instance.collection('Customers')
        .doc(currentCustomerUID)
        .update({
      'currentCartCost' : FieldValue.increment(productPrice),
      'currentCartQuantity' : FieldValue.increment(1),
    });
    }
    notifyListeners();
  }

  Future<void> removeFromCart({
    required String productId,
  }) async{
    await FirebaseFirestore.instance.collection('Customers')
        .doc(currentCustomerUID).collection('CartList').doc(productId)
        .delete();
    notifyListeners();
  }

  Future<void> clearCart() async{
    await FirebaseFirestore.instance.collection('Customers')
        .doc(currentCustomerUID).collection('CartList')
        .doc().delete();
    notifyListeners();
  }

  //
  // void removeCartItem ({required String productId}){
  //   _cartItems.remove(productId);
  //   notifyListeners();
  // }
  //
  // void clearCart (){
  //   _cartItems.clear();
  //   notifyListeners();
  // }
}