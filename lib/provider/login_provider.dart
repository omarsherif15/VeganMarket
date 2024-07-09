import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopmart2/consts/consts.dart';
import 'package:shopmart2/models/customerModel/customer_model.dart';

class LoginProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = '';
  Future<void> loginEmailAndPassword(
      {required email, required password}) async {
    isLoading = true;
    notifyListeners();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((onValue){
            currentCustomerUID = onValue.user?.uid;
            getCustomerData(currentCustomerUID!);
          }) ;
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

  Future<void> googleSignIn() async {
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



  bool isForgetPasswordLoading = false;
  bool isForgetPasswordError = false;
  String forgetPasswordErrorMsg = '';
  Future<void> forgetPassword(String email) async {
    isForgetPasswordLoading = true;
    notifyListeners();
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
      isForgetPasswordError = false;
      isForgetPasswordLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error.message);
      }
      isForgetPasswordError = true;
      forgetPasswordErrorMsg = error.message.toString();
      isForgetPasswordLoading = false;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      isForgetPasswordError = true;
      forgetPasswordErrorMsg = error.toString();
      isForgetPasswordLoading = false;
      notifyListeners();
    }
    isForgetPasswordLoading = false;
  }

  Future<void> getCustomerData(String customerUid) async{
    await FirebaseFirestore.instance.collection('Customers').doc(customerUid).get()
        .then((onValue){
          customerModel = CustomerModel.fromJson(onValue.data());
          notifyListeners();
    }).catchError((onError){
      print(onError);
    });
  }

}


