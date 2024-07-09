import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/inner_screens/product_details.dart';
import 'package:shopmart2/models/productsModel/products_model.dart';
import 'package:shopmart2/models/wishlistModel/wishlist_model.dart';
import 'package:shopmart2/provider/cart_provider.dart';
import 'package:shopmart2/provider/wishList_provider.dart';
import 'package:shopmart2/services/general_methods.dart';
import '../../provider/products_provider.dart';


class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key, required this.wishlistModel});

  final WishlistModel wishlistModel;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    ProductModel productModel = productProvider.findProductById(wishlistModel.productId) as ProductModel;
    final cartProvider = Provider.of<CartProvider>(context);

    //
    // bool _isInCart = cartProvider.getCartItem.containsKey(wishlistModel.productId);
    // bool _isInWishlist = wishlistProvider.getWishlistItem.containsKey(wishlistModel.productId);



    return Consumer<WishlistProvider>(
      builder: (_,provider, child) => InkWell(
        onTap: () {
          GlobalMethods().navigateTo(context: context, route: ProductDetails(productId: productModel.id, price: productModel.salePrice, quantity: 1,));
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
                image: NetworkImage(productModel.imageUrl),
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
                              productModel.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            child: true ?  const Icon(IconlyBold.heart, color: Colors.red,) : const Icon(IconlyLight.heart),
                              onTap: () {
                                provider.addAndRemoveFromWishlist(productId: wishlistModel.productId);
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
                                            text: productModel.isOnSale ? productModel.salePrice.toString() : productModel.price.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.green),
                                          ),
                                        ]),
                                  ),
                                  Visibility(
                                    visible: productModel.isOnSale,
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'EGP ',
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 12,
                                          ),
                                          children:  [
                                            TextSpan(
                                              text: productModel.price.toString(),
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
                      cartProvider.addProductsToCart(
                          productId: wishlistModel.productId,
                          quantity: 1,
                        productPrice: productModel.isOnSale ? productModel.salePrice : productModel.price

                      );
                    },
                    child: const Text(!false ? 'Add To Cart' : 'In Cart',style: TextStyle(fontSize: 15),)),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
