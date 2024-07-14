import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/models/addressModel/address_model.dart';
import 'package:shopmart2/provider/address_provider.dart';
import 'package:shopmart2/screens/profile/address_screen/add_address_screen.dart';
import 'package:shopmart2/screens/profile/address_screen/address_widget.dart';
import 'package:shopmart2/services/general_methods.dart';
import 'package:shopmart2/widgets/fallBack_widget.dart';

import '../../../consts/consts.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (_, provider, child) => StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Customers')
            .doc(currentCustomerUID)
            .collection('ShippingAddress')
            .snapshots(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SpinKitThreeBounce(
              size: 50,
              color: Colors.green,
            ));
          } else if (snapShot.connectionState == ConnectionState.active) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('My Address'),
                titleSpacing: 5,
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) => AddressWidget(
                    deleteFunction:() => provider.deleteShippingAddress(snapShot.data!.docs[index].data()['shippingAddressID']),
                      shippingAddress: ShippingAddress.fromJson(
                          snapShot.data!.docs[index].data())),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: snapShot.data!.docs.length),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  GlobalMethods()
                      .navigateTo(context: context, route: AddAddressScreen());
                },
                backgroundColor: Colors.green,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            );
          }
          return FallBack(
              msg: 'Ops, Its Seems like you have no Address',
              image: 'assets/random/warning-sign.png',
              buttonTitle: 'Add Address Now',
              onTap: () => GlobalMethods()
                  .navigateTo(context: context, route: AddAddressScreen()));
        },
      ),
    );
  }
}
