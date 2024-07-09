import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/inner_screens/product_details.dart';
import 'package:shopmart2/models/cartModel/cart_model.dart';
import 'package:shopmart2/provider/cart_provider.dart';
import 'package:shopmart2/services/general_methods.dart';
import 'package:shopmart2/widgets/plus_minus_widget.dart';

import '../../models/productsModel/products_model.dart';
import '../../provider/products_provider.dart';

class CartWidget extends StatelessWidget{
  const CartWidget({super.key, required this.cartModel,});

   final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    ProductsProvider provider = Provider.of<ProductsProvider>(context);
    ProductModel? productModel = provider.findProductById(cartModel.productId);

        return Consumer<CartProvider>(
        builder: (_, provider, child) =>
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: GestureDetector(
            onTap: (){
              GlobalMethods().navigateTo(context: context, route: ProductDetails(productId: cartModel.productId, price: productModel.salePrice, quantity: cartModel.quantity!,));        },
            child: Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  Image(image: NetworkImage(productModel!.imageUrl),height: 75, width: 75,),
                  Flexible(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(productModel.title,style: const TextStyle(fontSize: 20),maxLines: 1, overflow: TextOverflow.ellipsis,),
                        PlusMinusCart(
                            count: cartModel.quantity,
                          onTapMinus: (){
                            provider.decreaseQuantityByOne(
                              edit: true,
                                productId: cartModel.productId!,
                                productPrice: productModel.isOnSale? productModel.salePrice : productModel.price
                            );
                          },
                          onTapPlus: () {
                            provider.increaseQuantityByOne(
                              edit: true,
                                productId: cartModel.productId!,
                                productPrice: productModel.isOnSale? productModel.salePrice : productModel.price

                            );
                          }
                          ,),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'EGP',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 10,
                            ),
                            children: [
                              TextSpan(
                                text: productModel.isOnSale ?
                                (productModel.salePrice*int.parse(cartModel.quantity.toString())).toStringAsFixed(2):
                                (productModel.price*int.parse(cartModel.quantity.toString())).toStringAsFixed(2),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.green),
                              ),
                            ]),
                      ),
                      TextButton(
                          onPressed: (){
                            provider.removeFromCart(productId: cartModel.productId!);
                          },
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap
                          ),
                          child: const Text('Remove'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}
