import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/consts/consts.dart';
import 'package:shopmart2/models/wishlistModel/wishlist_model.dart';
import 'package:shopmart2/provider/order_provider.dart';
import 'package:shopmart2/screens/profile/wishlist/wishlist_widget.dart';
import 'package:shopmart2/provider/wishList_provider.dart';
import 'package:shopmart2/screens/main_screen.dart';
import 'package:shopmart2/widgets/fallBack_widget.dart';
import '../../../provider/dark_theme_provider.dart';
import '../../../widgets/warning_dialog.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(currentCustomerUID);
    return Consumer<WishlistProvider>(
        builder: (_, provider, child) => StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Customers')
                .doc(currentCustomerUID)
                .collection('WishList')
                .snapshots(),
            builder: (context, snapShot) {
              print(snapShot.connectionState);
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: SpinKitThreeBounce(
                  size: 50,
                  color: Colors.green,
                ));
              } else if (snapShot.connectionState == ConnectionState.active) {
                return ConditionalBuilder(
                  condition: snapShot.data!.docs.isNotEmpty,
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        'Wishlist',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      centerTitle: true,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: IconButton(
                              onPressed: () {
                                WarningDialog().showWarningDialog(
                                    context: context,
                                    msg: 'Sure want to Clear Wishlist?',
                                    title: 'Clear Wishlist',
                                    function: () {
                                      provider.clearWish();
                                      Navigator.pop(context);
                                    });
                              },
                              icon: const Icon(IconlyBroken.delete)),
                        )
                      ],
                    ),
                    body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.85,
                          padding: EdgeInsets.zero,
                          children: List.generate(
                              snapShot.data!.docs.length,
                              (index) => WishlistWidget(
                                  wishlistModel: WishlistModel.fromJson(
                                      snapShot.data!.docs[index].data()))),
                        )),
                  ),
                  fallback: (context) => FallBack(
                    msg:
                        'You Wished for Nothing\nLets make your wish come true',
                    image: 'assets/random/wishlist.png',
                    buttonTitle: 'Browse Products',
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => MainScreen()));
                      // themeState.selectedScreen(0);
                    },
                  ),
                );
              }
              return Container();
            }));
  }
}
