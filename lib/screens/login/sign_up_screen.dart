import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/provider/signup_provider.dart';
import 'package:shopmart2/screens/boarding/fetch_screen.dart';
import 'package:shopmart2/screens/login/login_screen.dart';
import 'package:shopmart2/widgets/or_divider_widget.dart';
import 'package:shopmart2/widgets/show_toast.dart';
import 'package:toastification/toastification.dart';

import '../../services/general_methods.dart';
import '../../widgets/text_field_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  var signUpFormKey = GlobalKey<FormState>();
  bool hidePassword  = true;
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPassFocus = FocusNode();



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupProvider(),
      child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
            SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Text(
                  'Sign Up to get Started',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
            Form(
              key: signUpFormKey,
              child: Column(
                children: [
                  MyTextField(
                    icon: const Icon(
                      IconlyBroken.profile,
                      color: Colors.green,
                    ),
                    hint: 'Full Name',
                    textEditingController: nameTextController,
                    focusNode: nameFocus,
                    gotoFocusNode: emailFocus,
                    validate: (value){
                      if(value!.isEmpty) {
                        return 'Full name must be filled';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    icon: const Icon(
                      IconlyBroken.message,
                      color: Colors.green,
                    ),
                    hint: 'Email Address',
                    textEditingController: emailTextController,
                    focusNode: emailFocus,
                    gotoFocusNode: passwordFocus,
                    validate: (value){
                      if(value!.isEmpty || !value.contains('@')) {
                        return 'Email Address must be filled';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    icon: const Icon(
                      IconlyBroken.lock,
                      color: Colors.green,
                    ),
                    hint: 'Password',
                    textEditingController: passwordTextController,
                    focusNode: passwordFocus,
                    gotoFocusNode: confirmPassFocus,
                    validate: (value){
                      if(value!.isEmpty) {
                        return 'Password Address must be filled';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    icon: const Icon(
                      IconlyBroken.lock,
                      color: Colors.green,
                    ),
                    hint: 'Confirm Password',
                    textEditingController: confirmPasswordTextController,
                    focusNode: confirmPassFocus,
                    gotoFocusNode: confirmPassFocus,
                    validate: (value){
                      if(value!.isEmpty) {
                        return 'Confirm Password must be filled';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  Consumer<SignupProvider>(
                      builder: (_, myProvider, child) {
                    return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              minimumSize: const Size(double.infinity, 50)),
                          onPressed: () {
                            if(signUpFormKey.currentState!.validate()){
                              myProvider.signUpEmailAndPassword(
                                  email: emailTextController.text,
                                  password: passwordTextController.text
                              ).whenComplete(() {
                                if(myProvider.isError){
                                  showToast(ToastificationType.error, myProvider.errorMsg);
                                }
                                else {
                                  GlobalMethods().navigateTo(context: context, route: const FetchScreen());
                                  myProvider.createUser(
                                    fullName: nameTextController.text,
                                    emailAddress: emailTextController.text,
                                    loginType: 'LoginEmailAndPassword',
                                    phoneNumber: '01010387741',
                                    imageUrl: 'https://i.ibb.co/9VKXw5L/Avocat.png',
                                  );
                                }
                              },);
                              }
                            else {
                              if (kDebugMode) {
                                print('not valid');
                              }
                            }
                          },
                          child: !myProvider.isLoading ?
                          const Text(
                            "Create Account",
                            style: TextStyle(
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
                ],
              ),
            ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const OrDivider(),
                    Consumer<SignupProvider>(
                      builder: (_,myProvider, child) =>
                       ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              minimumSize: const Size(double.infinity, 50)),
                          onPressed: () {
                            if(signUpFormKey.currentState!.validate()){
                              myProvider.googleSignUp().whenComplete(() {
                                if(myProvider.isError){
                                  showToast(ToastificationType.error, myProvider.errorMsg);
                                }
                                else {
                                  GlobalMethods().navigateTo(context: context, route: const FetchScreen());
                                  myProvider.createUser(
                                    fullName: nameTextController.text,
                                    emailAddress: emailTextController.text,
                                    loginType: 'GoogleSignUP',
                                    phoneNumber: '01010387741',
                                    imageUrl: 'https://i.ibb.co/9VKXw5L/Avocat.png',
                                  );
                                }
                              },);
                            }
                            else {
                              if (kDebugMode) {
                                print('not valid');
                              }
                            }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/random/google.png'),
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Sign Up with Google",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          )),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        'Already have an Account? ',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            GlobalMethods().navigateTo(context: context, route: LoginScreen());
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.green),
                          ))
                    ]),
                  ],
                ),
              ]),
            ),
          )),
    );
  }

}
