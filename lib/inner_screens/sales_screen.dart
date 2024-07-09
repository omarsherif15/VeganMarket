import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/widgets/fallBack_widget.dart';

import '../provider/products_provider.dart';
import '../screens/main_screen.dart';
import '../services/general_methods.dart';
import '../widgets/sales_item_widget.dart';

class OnSaleScreen extends StatelessWidget {
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( 'On Sale ',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Consumer<ProductsProvider>(
        builder: (_, provider, child) => ConditionalBuilder(
          condition: true,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 15,
              childAspectRatio: 0.85,
              padding: EdgeInsets.zero,
              children: List.generate(
                provider.productOnSale.length
              , (index) =>
                  ProductCardBuilder(productModel: provider.productOnSale[index]),),
            ),
          ),
          fallback: (context) => FallBack(
            msg: 'No products on sale yet!\nStay Tuned',
            image: 'assets/random/box.png',
            buttonTitle: 'Refresh',
            onTap: (){
              GlobalMethods().navigateTo(context: context, route: MainScreen());
            },
          ),
        ),
      ),
    );
  }
}
