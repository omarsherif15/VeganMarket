import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shopmart2/models/cartModel/cart_model.dart';
import 'package:shopmart2/models/orders_model/order_model.dart';
import 'package:shopmart2/provider/cart_provider.dart';

import '../consts/consts.dart';

class OrdersProvider with ChangeNotifier {

  List<OrderModel> orders = [];
  List<OrderModel> activeOrders = [];
  List<OrderModel> cancelledOrders = [];
  List<OrderModel> completedOrders = [];
  bool loadingOrders = false;

  Future<void> getMyOrders() async {
    loadingOrders = true;
    notifyListeners();
    await FirebaseFirestore.instance.collection('Orders').get().then((value) {
      orders = [];
      activeOrders = [];
      cancelledOrders = [];
      completedOrders = [];
      for (var element in value.docs) {
        orders.add(OrderModel.fromJson(element.data()));
        if(element.data()['userUid'] == currentCustomerUID) {
          if(element.data()['status'] == 'Active'){
            activeOrders.add(OrderModel.fromJson(element.data()));
          }else if(element.data()['status'] == 'Completed'){
            completedOrders.add(OrderModel.fromJson(element.data()));
          }else if(element.data()['status'] == 'Cancelled'){
            cancelledOrders.add(OrderModel.fromJson(element.data()));
          }
        }
      }
    });
    loadingOrders = false;
    notifyListeners();
  }

  Future<List<CartModel>> getCartItems (customerId)async{
    List<CartModel> cartItems = [];
    await FirebaseFirestore.instance.collection('Customers').doc(
        currentCustomerUID).collection('CartList').snapshots().forEach((value){
      for (var element in value.docs) {
        cartItems.add(CartModel.fromJson(element.data()));
      }
      print(cartItems);
    });
    return cartItems;
  }


  Future<void> createNewOrder({
    required String orderId,
    required String?  comment,
    required String? shippingAddress,
    required String? phoneNo,
    required int quantity,
    required double totalPrice,
    required double shippingFee,
    required List<Map<String, dynamic>> cartItems,
    required String status,
  }) async {
    OrderModel orderModel = OrderModel(
      orderId: orderId,
      userUid: currentCustomerUID,
      totalPrice: totalPrice,
      totalQuantity: quantity,
      cartItems: cartItems,
      status: status,
      comment: comment,
      orderAddress: shippingAddress,
      phoneNo: phoneNo,
      shipping: shippingFee,
      createdAt: DateFormat('dd/MM/yyyy kk:mm ').format(DateTime.now()),
    );
      print('a7aaaaaaaaaaaaa');
      try
    {
      await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderId)
          .set(orderModel.toMap());
    }
    on FirebaseException catch (e){
        print(e.message);
    }
    print('a7aaaaaaaaaaaaa333333');

  }
}