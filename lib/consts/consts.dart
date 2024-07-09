import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopmart2/models/customerModel/customer_model.dart';

String? currentCustomerUID = FirebaseAuth.instance.currentUser?.uid;
CustomerModel? customerModel;