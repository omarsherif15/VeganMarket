import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/models/productsModel/products_model.dart';
import 'package:shopmart2/widgets/plus_minus_widget.dart';
import '../provider/cart_provider.dart';
import '../provider/products_provider.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.productId, required this.price, required this.quantity});

  final String? productId;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    int count = 1;
    final productProvider = Provider.of<ProductsProvider>(context);
    ProductModel? productModel = productProvider.findProductById(productId);
    double totalPrice = productModel!.isOnSale ? productModel.salePrice * count : productModel.price * count;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = false; //customerModel.inCartList?.any((item) => item.productId == productModel!.id);


    return Scaffold(
      appBar: AppBar(),
      body: Consumer<CartProvider>(
        builder: (_, provider, child) => Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Image(image: NetworkImage(productModel.imageUrl)),
              ),
            ),
            Expanded(
              flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.grey.shade200,
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(productModel.title,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                            const Spacer(),
                            InkWell(
                              child: const Icon(IconlyLight.heart),
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'EGP ',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 15,
                                  ),
                                  children: [
                                     TextSpan(
                                      text: productModel.isOnSale? productModel.salePrice.toStringAsFixed(2) : productModel.price.toStringAsFixed(2),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.green),
                                    ),
                                    TextSpan(
                                      text: '/Kg',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[800]),
                                    ),
                                  ]),
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                              child: const Text('Free delivery',style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                        const SizedBox(height: 15,),
                        const Text('Fun Facts :)',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(productModel.description),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Quantity',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                const SizedBox(height: 10,),
                                PlusMinusCart(
                                    count: count,
                                    onTapMinus: (){
                                     provider.decreaseQuantityByOne(
                                         productId: productId!,
                                         productPrice: productModel.isOnSale? productModel.salePrice : productModel.price
                                     );
                                    },
                                    onTapPlus: () {
                                     provider.increaseQuantityByOne(
                                         productId: productId!,
                                         productPrice: productModel.isOnSale? productModel.salePrice : productModel.price

                                     );
                                    }
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Total',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                const SizedBox(height: 10,),
                                RichText(
                                  text: TextSpan(
                                      text: 'EGP',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 15,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: totalPrice.toStringAsFixed(2),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: Colors.green),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                elevation: 20,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                minimumSize: const Size(double.infinity, 50)
                            ),
                            onPressed: (){
                              !isInCart ?
                              cartProvider.addProductsToCart(
                                  productId: productModel.id,
                                  quantity: count,
                                  productPrice: productModel.isOnSale ? productModel.salePrice : productModel.price

                              )
                                  :
                                  print('in Cart');
                            },
                            child: Text(!isInCart ? "Add to Cart for ${totalPrice.toStringAsFixed(2)} EGP" : 'Already in Cart',
                              style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18), )
                        ),


                      ],
                    ),
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }
}
