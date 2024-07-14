import 'package:flutter/material.dart';
import 'package:shopmart2/screens/profile/orders/order_details.dart';
import 'package:shopmart2/services/general_methods.dart';

import '../../../models/orders_model/order_model.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
      child: Card(
        elevation: 5,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green.shade100,
                ),
                child: Text('${orderModel.status}',style: const TextStyle(fontSize: 15)),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Order ID',style: TextStyle(fontSize: 12,color: Colors.grey),),
                      Text('#${orderModel.orderId?.toUpperCase()}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Order Date',style: TextStyle(fontSize: 12,color: Colors.grey),),
                      Text('${orderModel.createdAt?.split(' ')[0]}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Payment',style: TextStyle(fontSize: 12,color: Colors.grey),),
                      Text('EGP ${orderModel.totalPrice}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                    ],
                  ),

                ],
              ),
              const SizedBox(height: 20,),
              Container(width: double.infinity,color: Colors.grey,height: 1,),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: (){
                        GlobalMethods().navigateTo(context: context, route: OrderDetails(orderModel: orderModel,));
                      },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width*0.38,50),
                      backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                        ),
                      side: BorderSide.none
                    ),
                      child: const Text('Veiw Details',style: TextStyle(color: Colors.green),),
                  ),
                  const SizedBox(width: 10,),
                  OutlinedButton(
                      onPressed: (){},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width*0.38,50),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                          side: BorderSide.none
                    ),
                      child: const Text('Re-Order',style: TextStyle(color: Colors.white),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
