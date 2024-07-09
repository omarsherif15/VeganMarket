import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/widgets/fallBack_widget.dart';
import 'package:shopmart2/widgets/search_feild.dart';

import '../provider/products_provider.dart';
import '../screens/main_screen.dart';
import '../services/general_methods.dart';
import '../widgets/sales_item_widget.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {

      return Consumer<ProductsProvider>(
      builder: (_, provider, child) =>  Scaffold(
      appBar: AppBar(
        title: const Text( 'Products'),
      ),
      body: ConditionalBuilder(
          condition: provider.newProductsList.isNotEmpty,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SearchField(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 15,
                      childAspectRatio: 0.85,
                      padding: EdgeInsets.zero,
                      children: List.generate(
                        provider.newProductsList.length,
                        (index) => ProductCardBuilder(productModel: provider.newProductsList[index]),),
                    ),
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => FallBack(
                msg: 'OPS, No products yet!\nStay Tuned',
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
