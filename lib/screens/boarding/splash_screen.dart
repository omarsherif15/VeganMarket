import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/consts/consts.dart';
import 'package:shopmart2/provider/signup_provider.dart';
import 'package:shopmart2/screens/home_screen.dart';
import 'package:shopmart2/screens/login/login_screen.dart';

import '../../provider/dark_theme_provider.dart';
import '../main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return FlutterSplashScreen.fadeIn(
      asyncNavigationCallback: () async { await themeState.getCustomerData();},
        nextScreen: FirebaseAuth.instance.currentUser == null ? LoginScreen() :  MainScreen(),
        childWidget: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/landing/background4.jpg'),fit: BoxFit.fitHeight,),
        color: Colors.white,
      ),

      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: const AssetImage('assets/vegan_logo.png'),height: MediaQuery.of(context).size.height*0.6,width: MediaQuery.of(context).size.height*0.6),
          Container(height: 200,)
        ],
      ),
    ));
  }
}
