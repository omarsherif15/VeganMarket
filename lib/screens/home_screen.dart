import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/provider/products_provider.dart';
import 'package:shopmart2/widgets/sales_item_widget.dart';
import '../inner_screens/products_screen.dart';
import '../inner_screens/sales_screen.dart';
import '../services/general_methods.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Image(
            image: AssetImage('assets/vegan_logo2.png'),
            width: 50,
            height: 50,
          ),
          titleSpacing: 5,
          title: Row(
            children: [
              RichText(
                text: TextSpan(
                    text: 'VEGAN',
                    style: TextStyle(
                        color: Colors.lightGreen[600],
                        fontWeight: FontWeight.w800,
                        fontSize: 25),
                    children: [
                      TextSpan(
                          text: ' MARKET',
                          style: TextStyle(
                              color: Colors.green[500],
                              fontWeight: FontWeight.w800,
                              fontSize: 25)),
                    ]),
              ),
            ],
          ),
        ),
        body: Consumer<ProductsProvider>(
          builder: (_,provider, child) {
            return SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.33,
                child: Swiper(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  controller: SwiperController(),
                  autoplay: true,
                  containerHeight: MediaQuery.of(context).size.height * 0.33,
                  indicatorLayout: PageIndicatorLayout.COLOR,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(),
                  ),
                  itemBuilder: (context, index) => Image(
                    image: AssetImage('assets/banners/banner_$index.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(15),
                            child: const Row(
                              children: [
                                Text(
                                  'ON SALE',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  IconlyLight.discount,
                                  size: 28,
                                  color: Colors.red,
                                )
                              ],
                            )),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                              GlobalMethods().navigateTo(
                                  context: context, route: const OnSaleScreen());
                          },
                          child: const Text('See More'),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.26,
                        child:  ListView.separated(
                                    padding: const EdgeInsets.all(8),
                                    itemBuilder: (context, index) =>
                                        ProductCardBuilder(productModel: provider.productOnSale[index]),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 10),
                                    itemCount: provider.productOnSale.length,
                                    scrollDirection: Axis.horizontal,
                                  )),
                    Row(
                      children: [
                        Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(15),
                            child: const Row(
                              children: [
                                Text(
                                  'Our Products',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ],
                            )),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            GlobalMethods().navigateTo(
                                context: context, route: const ProductsScreen());
                          },
                          child: const Text('See More'),
                        ),
                      ],
                    ),
                    GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 0.85,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                      provider.newProductsList.length,
                                      (index) => ProductCardBuilder(
                                          productModel: provider.newProductsList[index])))
                  ],
                ),
              )
            ],
          ));
          },
        ));
  }
}
