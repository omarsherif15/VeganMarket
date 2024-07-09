import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/consts/consts.dart';
import 'package:shopmart2/models/cartModel/cart_model.dart';
import 'package:shopmart2/provider/cart_provider.dart';
import 'package:shopmart2/provider/order_provider.dart';
import 'package:shopmart2/screens/cart/cart_widget.dart';
import 'package:shopmart2/stripePaymentManger/payment_manger.dart';
import 'package:shopmart2/widgets/fallBack_widget.dart';
import 'package:uuid/uuid.dart';
import '../../services/general_methods.dart';
import '../../widgets/warning_dialog.dart';
import '../home_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    return Consumer<CartProvider>(
      builder: (_,provider, child) =>
       StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Customers').doc(currentCustomerUID).collection('CartList').snapshots(),
        builder: (context, snapShot) {
         provider.getCartItems(customerModel);
          print(provider.cartItems);
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: SpinKitThreeBounce(
              size: 50,
              color: Colors.green,
            ));
          }
          else if (snapShot.connectionState == ConnectionState.active) {
              return ConditionalBuilder(
                    condition: snapShot.data!.docs.isNotEmpty,
                    builder: (context) =>
                        Scaffold(
                            appBar: AppBar(
                              automaticallyImplyLeading: false,
                              title: Text('My Cart (${customerModel!.currentCartQuantity})',
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                              titleSpacing: 30,
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: IconButton(
                                      onPressed: () {
                                        WarningDialog().showWarningDialog(
                                            context: context,
                                            msg: 'Sure want to Clear Cart?',
                                            title: 'Clear Cart',
                                            function: () {provider.clearCart(); Navigator.pop(context);},
                                        );
                                      },
                                      icon: const Icon(IconlyBroken.delete)
                                  ),
                                )
                              ],
                            ),
                            body: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          elevation: 20,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  15)),
                                          minimumSize: const Size(
                                              double.infinity, 50)
                                      ),
                                      onPressed: () {
                                        final uid = const Uuid().v4().substring(0,7);
                                        PaymentManger.stripePayment(40, 'USD');
                                        ordersProvider.createNewOrder(
                                            orderId: uid,
                                            quantity: customerModel!.currentCartQuantity,
                                            totalPrice: customerModel!.currentCartCost,
                                            cartItems: provider.cartItems,
                                            status: 'Active'
                                        );
                                      },
                                      child: Text("Checkout ${customerModel!.currentCartQuantity} Items for ${customerModel!.currentCartCost} EGP",
                                        style: const TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),)
                                  ),
                                  const SizedBox(height: 8,),
                                  Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        print(snapShot.data!.docs[index]['productId']);
                                        return CartWidget(cartModel: CartModel.fromJson(snapShot.data!.docs[index].data()));
                                      },
                                      separatorBuilder: (context, index) => const SizedBox(height: 10,),
                                      itemCount: snapShot.data!.docs.length,
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                    fallback:
                        (context) =>
                        FallBack(
                          msg: 'No Items in your Cart',
                          image: 'assets/random/cart.png',
                          buttonTitle: 'Shop Now',
                          onTap: () {
                            GlobalMethods().navigateTo(
                                context: context, route: const HomeScreen());
                          },
                        )
                );
            }
          return const Text('data');
          }
      ),
    );
  }
}
