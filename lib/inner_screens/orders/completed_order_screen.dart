import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/inner_screens/orders/order_widget.dart';
import 'package:shopmart2/provider/order_provider.dart';

class CompletedOrdersScreen extends StatelessWidget {
  const CompletedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(
      builder: (_, provider, child) => ListView.builder(
          itemCount: provider.completedOrders.length,
          itemBuilder: (context,index) => OrderWidget(orderModel: provider.completedOrders[index],)
      ),
    );
  }
}
