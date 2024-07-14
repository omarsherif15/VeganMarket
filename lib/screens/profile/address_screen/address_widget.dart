import 'package:flutter/material.dart';
import 'package:shopmart2/models/addressModel/address_model.dart';
import 'package:shopmart2/screens/profile/address_screen/add_address_screen.dart';
import 'package:shopmart2/services/general_methods.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key, required this.shippingAddress, this.deleteFunction});
  final ShippingAddress shippingAddress;
  final void Function()? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${shippingAddress.name}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    Text('${shippingAddress.phoneNo}',style: TextStyle(fontSize: 18),),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () => GlobalMethods().navigateTo(context: context, route: AddAddressScreen(isEdit: true,addressModel: shippingAddress,)),
                    icon: const Icon(Icons.edit, color: Colors.green,)),
                IconButton(
                    onPressed: deleteFunction,
                    icon: const Icon(Icons.delete_outline, color: Colors.red,)),
              ],
            ),
            SizedBox(height: 15,),
            Text('${shippingAddress.houseNo}, ${shippingAddress.streetAddress}',style: TextStyle(fontSize: 20),),
            Text('${shippingAddress.cityName}, ${shippingAddress.countryName}')
          ],
        ),
      ),
    );
  }
}
