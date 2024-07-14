import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/provider/order_provider.dart';
import 'package:shopmart2/widgets/fallBack_widget.dart';

import '../../main_screen.dart';
import '../../../services/general_methods.dart';
import 'active_order_screen.dart';
import 'cancelled_order_screen.dart';
import 'completed_order_screen.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(
        builder: (_, provider ,child) => ConditionalBuilder(
            condition: !provider.orders.isNotEmpty,
            builder: (context) => DefaultTabController(
              length:3,
              child: Scaffold(
                backgroundColor: Colors.grey.shade100,
                appBar: AppBar(
                  title: const Text('My Orders',style: TextStyle(fontWeight: FontWeight.bold),),
                  centerTitle: true,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(55),
                    child: Container(
                      color: Colors.white,
                      child: TabBar(
                        tabs: tabBar,
                        labelPadding: EdgeInsets.zero,
                        indicatorPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 5,
                        indicatorColor: Colors.green,
                      ),
                    ),
                  ),
                ),
                body: const TabBarView(
                  children: [
                    ActiveOrdersScreen(),
                    CompletedOrdersScreen(),
                    CancelledOrdersScreem(),
                  ],
                ),
              ),
            ),
            fallback:(context) =>  FallBack(
              msg: 'You have made no orders\nLets try making one',
              image: 'assets/random/box.png',
              buttonTitle: 'Order Now',
              onTap: (){
                GlobalMethods().navigateTo(context: context, route: MainScreen());
              },
            )
        ),
      );
  }
  List <Widget> tabBar = [
    Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: const Text('Active',style: TextStyle(color: Colors.grey,fontSize: 16),)
    ),
    Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: const Text('Completed',style: TextStyle(color: Colors.grey,fontSize: 16),)
    ),
    Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: const Text('Cancelled',style: TextStyle(color: Colors.grey,fontSize: 16),)
    ),
  ];
}
