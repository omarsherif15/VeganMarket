import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/screens/profile/orders/order_widget.dart';

import '../../../consts/consts.dart';
import '../../../models/orders_model/order_model.dart';
import '../../../provider/order_provider.dart';
import '../../../widgets/fallBack_widget.dart';

class ActiveOrdersScreen extends StatelessWidget {
  const ActiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool found = false;
    return Consumer<OrdersProvider>(
      builder: (_, provider, child) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Orders')
                .where("userUid", isEqualTo: "$currentCustomerUID")
                .where("status", isEqualTo: "Active").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print(snapshot.connectionState);
                return const Center(child: SpinKitThreeBounce(
                  size: 50,
                  color: Colors.green,
                ));
              }
              else if (snapshot.connectionState == ConnectionState.active) {
                print(snapshot.connectionState);
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) =>
                        OrderWidget(orderModel: OrderModel.fromJson(
                            snapshot.data!.docs[index].data()),)
                );
              }
              return FallBack(
                  msg: 'ops, Something Went wrong',
                  image: 'assets/random/warning-sign.png',
                  buttonTitle: 'Try Again',
                  onTap: (){}
              );
            }

        );
      }
    );
  }
}
