import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/consts/consts.dart';
import 'package:shopmart2/models/orders_model/order_model.dart';

import '../../../models/productsModel/products_model.dart';
import '../../../provider/products_provider.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text('${orderModel.orderId?.toUpperCase()}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),),
        titleSpacing: 0,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Omar Sherif', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
              const SizedBox(height: 20,),
              const Text('Address', style: TextStyle(fontSize: 13, color: Colors.grey),),
              Text('${orderModel.orderAddress}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone', style: TextStyle(fontSize: 13, color: Colors.grey),),
                      Text('${orderModel.phoneNo}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CreatedAt', style: TextStyle(fontSize: 13, color: Colors.grey),),
                      Text('${orderModel.createdAt}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              const Text('Email Address', style: TextStyle(fontSize: 13, color: Colors.grey),),
              Text('${customerModel!.emailAddress}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              const Text('Comments', style: TextStyle(fontSize: 13, color: Colors.grey),),
              Text('${orderModel.comment}', style: TextStyle(fontSize: 15),),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(15), topEnd: Radius.circular(15)),
                  border: Border.fromBorderSide(BorderSide(color: Colors.grey))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Order Products', style: TextStyle(fontSize: 13, color: Colors.grey),),
                    productPreview(orderModel.cartItems![0],context),
                    productPreview(orderModel.cartItems![1], context),
                    productPreview(orderModel.cartItems![2], context),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadiusDirectional.only(bottomStart: Radius.circular(15), bottomEnd: Radius.circular(15)),
                    border: const Border.fromBorderSide(BorderSide(color: Colors.grey))
                ),
                child: Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SubTotal', style: TextStyle(fontSize: 15),),
                        Text('Shipping', style: TextStyle(fontSize: 15),),
                        Text('Total', style: TextStyle(fontSize: 15),)
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('EGP ${orderModel.totalPrice}', style: TextStyle(fontSize: 15),),
                        Text(orderModel.shipping == 0 ? 'Free' : 'EGP ${orderModel.shipping}', style: TextStyle(fontSize: 15),),
                        Text('EGP ${orderModel.totalPrice! + orderModel.shipping!}', style: TextStyle(fontSize: 15),)
                      ],
                    )
                  ],
                ),
        
              )
            ],
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
        Text('${productModel?.title}', style: TextStyle(fontSize: 20),),
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
            Text('${cartItems['quantity']} Kilo',style: TextStyle(color: Colors.grey,fontSize: 15),)
          ],
        )
      ],
    );
  }
}
