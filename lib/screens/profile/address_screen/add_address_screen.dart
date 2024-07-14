import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/models/addressModel/address_model.dart';
import 'package:shopmart2/provider/address_provider.dart';
import 'package:shopmart2/widgets/text_field_widget.dart';
import 'package:uuid/uuid.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key, this.addressModel , this.isEdit = false});
  final ShippingAddress? addressModel;
  bool isEdit;
  var addressFormKey = GlobalKey<FormState>();
  TextEditingController titleTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController houseNoTextController = TextEditingController();
  TextEditingController streetTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController postalCodeTextController = TextEditingController();
  TextEditingController countryTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    if(isEdit){
      titleTextController.text = addressModel!.name!;
      phoneTextController.text = addressModel!.phoneNo!;
      houseNoTextController.text = addressModel!.houseNo!;
      streetTextController.text = addressModel!.streetAddress!;
      cityTextController.text = addressModel!.cityName!;
      postalCodeTextController.text = addressModel!.postCode!;
      countryTextController.text = addressModel!.countryName!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ?'Edit Address' : 'Add Address'),
        titleSpacing: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: addressFormKey,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Address Title', style: TextStyle(fontWeight: FontWeight.bold),),
                  MyTextField(
                    padding: 5,
                      hint: 'Address Title',
                      textEditingController: titleTextController,
                      decoration: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey)
                      ),
                      validate: (value){
                        return null;
                      },
                  ),
                  const SizedBox(height: 15,),
                  const Text('Phone Number', style: TextStyle(fontWeight: FontWeight.bold),),
                  MyTextField(
                    padding: 5,
                    hint: 'Address phone number',
                    textEditingController: phoneTextController,
                    decoration: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey)
                    ),
                    validate: (value){
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),

                  const Text('House Number', style: TextStyle(fontWeight: FontWeight.bold),),
                  MyTextField(
                    padding: 5,
                    hint: 'House Number',
                    textEditingController: houseNoTextController,
                    decoration: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey)
                    ),
                    validate: (value){
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),

                  const Text('Street Name', style: TextStyle(fontWeight: FontWeight.bold),),
                  MyTextField(
            padding: 5,
            hint: 'Street Name',
            textEditingController: streetTextController,
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey)
            ),
            validate: (value){
              return null;
            },
          ),
                  const SizedBox(height: 15,),

                  const Text('City', style: TextStyle(fontWeight: FontWeight.bold),),
                  MyTextField(
                    padding: 5,
                    hint: 'City Name',
                    textEditingController: cityTextController,
                    decoration: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey)
                    ),
                    validate: (value){
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),

                  const Text('Country', style: TextStyle(fontWeight: FontWeight.bold),),
                  MyTextField(
                    padding: 5,
                    hint: 'Country Name',
                    textEditingController: countryTextController,
                    decoration: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey)
                    ),
                    validate: (value){
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),

                  const Text('Postal Code', style: TextStyle(fontWeight: FontWeight.bold),),
                  MyTextField(
                    padding: 5,
                    hint: 'Postal Code',
                    textEditingController: postalCodeTextController,
                    decoration: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey)
                    ),
                    validate: (value){
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),

                  Consumer<AddressProvider>(
                      builder: (_, myProvider, child) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                minimumSize: const Size(double.infinity, 50)),
                            onPressed: () {
                              if (addressFormKey.currentState!.validate()) {
                              var uid = isEdit ? addressModel!.shippingAddressID! : const Uuid().v4();
                              myProvider.addShippingAddress(
                                  shippingAddressID: uid,
                                  name: titleTextController.text,
                                  houseNo: houseNoTextController.text,
                                  phoneNo: phoneTextController.text,
                                  streetAddress: streetTextController.text,
                                  cityName: cityTextController.text,
                                  countryName: countryTextController.text,
                                  postCode: postalCodeTextController.text)
                                  .then((value){
                                Navigator.pop(context);
                              });
                          }},
                            child: myProvider.shippingAddressLoading ?
                            Text(
                              !isEdit ? "Add New Address" : "Save Changes",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ) :
                            const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 30,
                            )
                        );
                      }
                  ),
                  const SizedBox(height: 15,),

                ],
              )
          ),
        ),
      ),
    );
  }
}
