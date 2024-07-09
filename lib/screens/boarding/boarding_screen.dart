import 'package:flutter/material.dart';
import 'package:shopmart2/screens/login/login_screen.dart';
import 'package:shopmart2/screens/login/sign_up_screen.dart';
import 'package:shopmart2/services/general_methods.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/landing/background4.jpg'),fit: BoxFit.fitHeight,),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          Image(image: const AssetImage('assets/vegan_logo.png'),height: MediaQuery.of(context).size.height*0.3,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 20,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  minimumSize: const Size(300, 50)
              ),
              onPressed: (){
                GlobalMethods().navigateTo(context: context, route: LoginScreen());
              },
              child: const Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18), )
          ),
          const SizedBox(height: 15,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 20,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  minimumSize: const Size(300, 50)
              ),
              onPressed: (){
                GlobalMethods().navigateTo(context: context, route: SignUpScreen());
              },
              child: const Text("Create an Account",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 18), )
          ),
          const SizedBox(height: 15,),

        ],
      ),
    );
  }
}
