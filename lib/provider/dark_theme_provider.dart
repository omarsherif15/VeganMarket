import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopmart2/services/dark_theme_prefs.dart';

import '../consts/consts.dart';
import '../models/customerModel/customer_model.dart';

class DarkThemeProvider with ChangeNotifier{
  DarkThemePrefs darkThemePrefs = DarkThemePrefs();
  bool _darkTheme = false;
  bool getDarkTheme() => _darkTheme;

  set setDarkTheme(bool value){
    _darkTheme = value;
    darkThemePrefs.setDarkThemeMode(value);
    notifyListeners();
  }

  int selectedIndex = 0;
  void selectedScreen (int index){
      selectedIndex = index;
      notifyListeners();
  }

  Future<void> getCustomerData() async{
    await FirebaseFirestore.instance.collection('Customers').doc(currentCustomerUID).get()
        .then((onValue){
      customerModel = CustomerModel.fromJson(onValue.data());
      notifyListeners();
    }).catchError((onError){
      print(onError);
    });
  }
}
