import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/widgets/fallBack_widget.dart';

import '../models/productsModel/products_model.dart';
import '../provider/products_provider.dart';
import '../screens/main_screen.dart';
import '../services/general_methods.dart';

class OneCategoryScreen extends StatelessWidget {
  OneCategoryScreen({required this.categoryName, super.key});

  String categoryName;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> categoryProducts = productProvider.findProductByCategory(categoryName);
    return Scaffold(
      appBar: AppBar(
        title: Text( categoryName,style: const TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ConditionalBuilder(
        condition: categoryProducts.isNotEmpty,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 15,
            childAspectRatio: 0.85,
            padding: EdgeInsets.zero,
            children: List.generate(categoryProducts.length, (index) =>Container()),
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
    );
  }
}
