import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/inner_screens/orders/order_widget.dart';

import '../../provider/order_provider.dart';

class ActiveOrdersScreen extends StatelessWidget {
  const ActiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(
      builder: (_, provider, child) {
        return ListView.builder(
          itemCount: provider.activeOrders.length,
          itemBuilder: (context,index) => OrderWidget(orderModel: provider.activeOrders[index],)
      );
      },
    );
  }
}
