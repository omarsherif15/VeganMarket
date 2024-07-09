import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopmart2/models/customerModel/customer_model.dart';
import 'package:intl/intl.dart';

class SignupProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = '';
  Future<void> signUpEmailAndPassword(
      {required email, required password}) async {
    isLoading = true;
    notifyListeners();
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      isError = false;
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error.message);
      }
      isError = true;
      errorMsg = error.message.toString();
      isLoading = false;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      isError = true;
      errorMsg = error.toString();
      isLoading = false;
      notifyListeners();
    }
    isLoading = false;
  }

  bool isGoogleLoading = false;
  bool isGoogleError = false;
  String googleErrorMsg = '';

  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  Future<void> googleSignUp() async {
    final googleSignIn = GoogleSignIn(scopes: scopes);
    final googleAccount = await googleSignIn.signIn();
    isGoogleLoading = true;
    notifyListeners();
    try {
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          await FirebaseAuth.instance.signInWithCredential(
              GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken));
        }
      }
      isGoogleError = false;
      isGoogleLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error.message);
      }
      isGoogleError = true;
      googleErrorMsg = error.message.toString();
      isGoogleLoading = false;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      isGoogleError = true;
      googleErrorMsg = error.toString();
      isGoogleLoading = false;
      notifyListeners();
    }
    isGoogleLoading = false;
  }


  Future<void> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (error) {
      print(error.message);
    }
  }

  CustomerModel? customerModel;
  Future<void> createUser({
    String? fullName,
    String? emailAddress,
    String? phoneNumber,
    String? imageUrl,
    required String loginType

}) async {
     customerModel = CustomerModel(
          customerUID: FirebaseAuth.instance.currentUser?.uid,
          fullName: fullName,
          emailAddress: emailAddress,
          phoneNumber: phoneNumber,
          imageUrl: imageUrl,
          createdAt: DateFormat('dd/MM/yyyy kk:mm ').format(DateTime.now()),
          loginType: loginType,
          totalSpent: 0,
          currentCartCost: 0,
          currentCartQuantity: 0,

    );
    await FirebaseFirestore.instance
        .collection('Customers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(customerModel!.toMap());
  }
}
