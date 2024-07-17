import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/consts/consts.dart';
import 'package:shopmart2/provider/order_provider.dart';
import 'package:shopmart2/stripePaymentManger/payment_manger.dart';
import 'package:shopmart2/widgets/fallBack_widget.dart';
import 'package:uuid/uuid.dart';

import '../../../models/productsModel/products_model.dart';
import '../../../provider/products_provider.dart';
import '../../../services/general_methods.dart';
import '../../../widgets/text_field_widget.dart';

class CreateNewOrder extends StatelessWidget {
  CreateNewOrder({super.key, required this.cartItems});

  final List<Map<String, dynamic>> cartItems;
  var commentTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(
      builder: (_, provider, child) =>
          ConditionalBuilder(
            condition: !provider.orderCreated,
            builder: (context) => Scaffold(backgroundColor: Colors.grey[200],
                    appBar: AppBar(
            title: const Text('Confirm Your Order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            centerTitle: true,
                    ),
                    body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Shipping Address', style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_outlined),
                          const SizedBox(width: 10,),
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: 'Home ',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                      children: const [
                                        TextSpan(
                                          text: '(+02) 01010387741',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey),
                                        ),
                                      ]),
                                ),
                                const Text("351 Mo Salah street, Alexandria, Egypt", style: TextStyle(color: Colors.grey),)
                              ],
                            ),
                          ),
                          const Icon(Icons.edit)
                        ],
                      )

                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Items Details',style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 15,),
                      productPreview(cartItems[0], context),
                      productPreview(cartItems[1], context),
                      productPreview(cartItems[2], context),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          const Text('Subtotal'),
                          const Spacer(),
                          RichText(
                            text: TextSpan(
                                text: 'EGP',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 10,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${customerModel?.currentCartCost}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.green),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                    height: 170,
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Shipping',style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15,),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: const Border.fromBorderSide(BorderSide(color: Colors.grey))
                                ),
                                child: Row(
                                  children: [
                                    Radio(
                                        value: 'free',
                                        groupValue: provider?.shippingFeeRadioButton,
                                        onChanged: (value){
                                          provider.toogleShippingFeeRadioButton(value);
                                        }
                                    ),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Standard Shipping',style: TextStyle(fontSize: 20),),
                                        Text('Delivery Within 7 Days',style: TextStyle(fontSize: 15,color: Colors.grey)),
                                        Text('Free',style: TextStyle(fontSize: 18, color: Colors.green)),
                                      ],
                                    ),
                                    const SizedBox(width: 15,)
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: const Border.fromBorderSide(BorderSide(color: Colors.grey))
                                ),
                                child: Row(
                                  children: [
                                    Radio(
                                        value: 'paid',
                                        groupValue: provider.shippingFeeRadioButton,
                                        onChanged: (value){
                                          provider.toogleShippingFeeRadioButton(value);
                                        }
                                    ),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Express Shipping',style: TextStyle(fontSize: 20),),
                                        Text('Delivery Within 2 Days',style: TextStyle(fontSize: 15,color: Colors.grey)),
                                        Text('EGP 50',style: TextStyle(fontSize: 18, color: Colors.green)),
                                      ],
                                    ),
                                    const SizedBox(width: 15,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                const SizedBox(height: 10),
                Container(
                  height: 170,
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Payment Methods',style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          Radio(
                              value: 'cash',
                              groupValue: provider.paymentMethodRadioButton,
                              onChanged: (value){
                                provider.tooglePaymentMethodRadioButton(value);
                              }
                          ),
                          const Text('Pay with Cash',style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Radio(
                              value: 'credit',
                              groupValue: provider.paymentMethodRadioButton,
                              onChanged: (value){
                                provider.tooglePaymentMethodRadioButton(value);
                              }
                          ),
                          const Text('Pay by Credit Card',style: TextStyle(fontSize: 20),),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Comment', style: TextStyle(fontWeight: FontWeight.bold),),
                      MyTextField(
                        maxLines: 3,
                        padding: 5,
                        hint: 'Write a Comment',
                        textEditingController: commentTextController,
                        decoration: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey)
                        ),
                        validate: (value){
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 140),
              ],
            ),
                    ),
                    bottomSheet: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('By continuing you accept the T&Cs',style: TextStyle(color: Colors.grey),),
                const SizedBox(height: 15,),
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
                      var uid = Uuid().v4();
                      if(provider.paymentMethodRadioButton == 'credit'){
                        PaymentManger.stripePayment(customerModel!.currentCartCost.ceil(), 'EGP').whenComplete((){
                          provider.createNewOrder(
                            orderId: uid.substring(0,8),
                            context: context,
                            comment: commentTextController.text,
                            shippingAddress: customerModel?.defaultShippingAddress?.split('/')[1],
                            phoneNo: customerModel?.phoneNumber,
                            quantity: customerModel!.currentCartQuantity,
                            totalPrice: provider.shippingFeeRadioButton == 'free' ? customerModel!.currentCartCost : customerModel!.currentCartCost + 50,
                            shippingFee: provider.shippingFeeRadioButton == 'free' ? 0.0 : 50,
                            cartItems: cartItems,
                            status: 'Active',
                          );
                        });
                      }
                      else{
                        provider.createNewOrder(
                          orderId: uid.substring(0,8),
                          context: context,
                          comment: commentTextController.text,
                          shippingAddress: customerModel?.defaultShippingAddress?.split('/')[1],
                          phoneNo: customerModel?.phoneNumber,
                          quantity: customerModel!.currentCartQuantity,
                          totalPrice: provider.shippingFeeRadioButton == 'free' ? customerModel!.currentCartCost : customerModel!.currentCartCost + 50,
                          shippingFee: provider.shippingFeeRadioButton == 'free' ? 0.0 : 50,
                          cartItems: cartItems,
                          status: 'Active',
                        );
                      }
                    },
                    child: Text("Submit Order (${provider.shippingFeeRadioButton == 'free' ? customerModel!.currentCartCost : customerModel!.currentCartCost + 50} EGP)",
                      style: const TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),)
                ),

              ],
            ),
                    ),
            ),
            fallback: (context) => orderCreated()
          ),
    );
  }

  Widget orderCreated (){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/orderCreated.gif'),height: 250, width: 250,),
                const Text('Order Placed', style: TextStyle(fontSize: 29,fontWeight: FontWeight.bold,color: Colors.red)),
                const SizedBox(height: 10,),
                const Text('Your Order has been Successfully processed and is on its way to you soon',textAlign: TextAlign.center,),
                const SizedBox(height: 30,),
                OutlinedButton(
                  onPressed: (){},
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity,50),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('My Order Details',style: TextStyle(color: Colors.white,) ),
                ),
                const SizedBox(height: 10,),
                OutlinedButton(
                  onPressed: (){},
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity,50),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide.none,
                    ),
                  ),
                  child: const Text('Continue Shopping',style: TextStyle(color: Colors.black,) ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget productPreview (Map<String, dynamic> cartItems, context){
    ProductsProvider provider = Provider.of<ProductsProvider>(context);
    ProductModel? productModel = provider.findProductById(cartItems['productId']);
    return Row(
      children: [
        Image(image: NetworkImage('${productModel?.imageUrl}'),height: 50, width: 50,),
        const SizedBox(width: 10,),
        Text('${productModel?.title}', style: const TextStyle(fontSize: 20),),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                  text: 'EGP',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 10,
                  ),
                  children: [
                    TextSpan(
                      text: '${productModel!.isOnSale ? productModel.salePrice*cartItems['quantity'] : productModel.price*cartItems['quantity']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green),
                    ),
                  ]),
            ),
            Text('${cartItems['quantity']} Kilo',style: const TextStyle(color: Colors.grey,fontSize: 15),)
          ],
        )
      ],
    );
    }
}
