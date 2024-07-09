
import 'package:flutter/material.dart';

class GlobalMethods{
  void navigateTo({required BuildContext context, required Widget route, int? arguments}){
    Navigator.push(context, MaterialPageRoute(builder: (context) => route),);  }
}

String carrot = 'https://purepng.com/public/uploads/large/purepng.com-carrotscarrotvegetablesfreshdeliciousefoodhealthycarrots-481521740717jmglq.png';
