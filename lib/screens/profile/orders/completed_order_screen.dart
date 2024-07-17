import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/consts/consts.dart';
import 'package:shopmart2/models/orders_model/order_model.dart';
import 'package:shopmart2/screens/profile/orders/order_widget.dart';
import 'package:shopmart2/provider/order_provider.dart';
import 'package:shopmart2/widgets/fallBack_widget.dart';

class CompletedOrdersScreen extends StatelessWidget {
  const CompletedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool found = false;
    return Consumer<OrdersProvider>(
      builder: (_, provider, child) => StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Orders')
            .where("userUid", isEqualTo: "$currentCustomerUID")
            .where("status", isEqualTo: "Completed").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SpinKitThreeBounce(
              size: 50,
              color: Colors.green,
            ));
          }
          else if (snapshot.connectionState == ConnectionState.active) {
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
      )
    );
  }
}
