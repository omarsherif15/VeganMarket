import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/inner_screens/orders/order_widget.dart';

import '../../provider/order_provider.dart';

class CancelledOrdersScreem extends StatelessWidget {
  const CancelledOrdersScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(
      builder: (_, provider, child) => ListView.builder(
          itemCount: provider.cancelledOrders.length,
          itemBuilder: (context,index) => OrderWidget(orderModel: provider.cancelledOrders[index],)
      ),
    );
  }
}
