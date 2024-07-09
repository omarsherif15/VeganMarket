import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/inner_screens/product_details.dart';
import 'package:shopmart2/provider/cart_provider.dart';
import 'package:shopmart2/provider/wishList_provider.dart';
import 'package:shopmart2/services/general_methods.dart';

import '../consts/theme_data.dart';
import '../models/productsModel/products_model.dart';
import '../provider/dark_theme_provider.dart';

class ProductCardBuilder extends StatelessWidget {
  const ProductCardBuilder({super.key, required this.productModel});

  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final themeData = Styles.themeData(themeState.getDarkTheme(), context);
    //final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    bool? isInCartList = false; //customerModel.inCartList?.any((item) => item.productId == productModel!.id);
    print(isInCartList);
    //bool _isInWishlist = wishlistProvider.getWishlistItem.containsKey(productModel!.id);
    int quantity = 1;

    return InkWell(
      onTap: () {
        GlobalMethods().navigateTo(context: context, route: ProductDetails(productId: productModel?.id, price: productModel!.salePrice, quantity: 1,));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade100, borderRadius: BorderRadius.circular(15)),
        height: 200,
        width: 155,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Image(
              image: NetworkImage(productModel!.imageUrl),
              height: 80,
              width: 80,
              fit: BoxFit.contain,
            ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                             Flexible(
                               flex: 5,
                               child: Text(
                                productModel!.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                               ),
                             ),
                            const Spacer(),
                            InkWell(
                              child:false ?  const Icon(IconlyBold.heart, color: Colors.red,) : const Icon(IconlyLight.heart),
                              onTap: () {
                                wishlistProvider.addAndRemoveFromWishlist(productId: productModel!.id);
                              },
                            ),
                          ],
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'EGP ',
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 12,
                                          ),
                                          children:  [
                                            TextSpan(
                                              text: productModel!.isOnSale ? productModel!.salePrice.toString() : productModel!.price.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.green),
                                            ),
                                          ]),
                                    ),
                                    Visibility(
                                      visible: productModel!.isOnSale,
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'EGP ',
                                            style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 12,
                                            ),
                                            children:  [
                                              TextSpan(
                                                text: productModel!.price.toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    decoration: TextDecoration.lineThrough,
                                                    color: Colors.grey),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ]),
                              const Spacer(),
                              const Text(
                                '1 KG',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /// Horizontal Divider
                Container(
                  height: 2,
                  width: 130,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: (){
                        !isInCartList ?
                        cartProvider.addProductsToCart(
                            productId: productModel!.id,
                            quantity: quantity,
                            productPrice: productModel!.isOnSale ? productModel!.salePrice : productModel!.price

                        )
                        :
                            print('inCart Already');
                      },
                      child: Text(!isInCartList ? 'Add To Cart' : 'In Cart',style: const TextStyle(fontSize: 15),)),
                ),
          ],
        ),
      ),
    );
  }

  // Future<void> showAddCartDialog(context, themeData,ProductModel productModel,CartProvider cartProvider, int count) async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         double newPrice = productModel.salePrice;
  //         return AlertDialog(
  //             title: Text('Add to Cart', style: themeData.textTheme.bodyMedium,),
  //             actions: [
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: const Text('Cancel')
  //               ),
  //               TextButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       cartProvider.addProductsToCart(
  //                           productId: productModel.id,
  //                           quantity: count
  //                       );
  //                       print(cartProvider.getCartItem.toString());
  //                     });
  //                   },
  //                   child: const Text('Add')
  //               ),
  //             ],
  //             content: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                       Text('Quantity'),
  //                       SizedBox(height: 10,),
  //                     PlusMinusCart(
  //                         count: count,
  //                         onTapMinus: (){
  //                           setState(() {
  //                             if (count > 1) {
  //                               count -= 1;
  //                               newPrice = count * productModel.salePrice;
  //                             }
  //                           });
  //                         },
  //                         onTapPlus: () {
  //                           setState(() {
  //                             count += 1;
  //                             newPrice = count * productModel.salePrice;
  //                           });
  //                         }
  //                     ),
  //                   ],
  //                 ),
  //                 Spacer(),
  //                 Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text('Total'),
  //                     SizedBox(height: 10,),
  //                     RichText(
  //                       text: TextSpan(
  //                           text: 'EGP ',
  //                           style: TextStyle(
  //                             color: Colors.grey[800],
  //                             fontSize: 10,
  //                           ),
  //                           children: [
  //                             TextSpan(
  //                               text: newPrice.toStringAsFixed(2),
  //                               style: const TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 20,
  //                                   color: Colors.green),
  //                             ),
  //                           ]),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             )
  //         );
  //       }
  //   );
  // }
}
