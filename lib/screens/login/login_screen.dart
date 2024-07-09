import 'package:flutter/foundation.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/provider/login_provider.dart';
import 'package:shopmart2/screens/login/forgetPassword.dart';
import 'package:shopmart2/screens/login/sign_up_screen.dart';
  import 'package:shopmart2/widgets/or_divider_widget.dart';
import 'package:toastification/toastification.dart';

  import '../../services/general_methods.dart';
  import '../../widgets/show_toast.dart';
import '../../widgets/text_field_widget.dart';
import '../main_screen.dart';

  class LoginScreen extends StatelessWidget {
    LoginScreen({super.key});

    var loginFormKey = GlobalKey<FormState>();
    bool hidePassword  = true;
    FocusNode passwordFocus = FocusNode();
    FocusNode emailFocus = FocusNode();
    TextEditingController emailTextController = TextEditingController();
    TextEditingController passwordTextController = TextEditingController();


    @override
    Widget build(BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) => LoginProvider(),
      child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const Text(
                      'Please Login to your Account',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: loginFormKey,
                      child: Column(
                        children: [
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
                              if(value!.isEmpty){
                                return 'Email Address must be filled';
                              }
                              else if (!value.contains('@')) {
                                return 'Please enter valid Email Address';
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
                            gotoFocusNode: passwordFocus,
                            validate: (value){
                              if(value == '') {
                                return 'Password Address must be filled';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                GlobalMethods().navigateTo(context: context, route: ForgetPassword());
                              },
                              style: TextButton.styleFrom(
                                alignment: AlignmentDirectional.centerEnd,
                              ),
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer<LoginProvider>(
                              builder: (_, myProvider, child) {
                                return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)),
                                        minimumSize: const Size(double.infinity, 50)),
                                    onPressed: () {
                                      if (loginFormKey.currentState!
                                          .validate()) {
                                        myProvider.loginEmailAndPassword(
                                            email: emailTextController.text,
                                            password: passwordTextController
                                                .text
                                        ).whenComplete(() {
                                          if (myProvider.isError) {
                                            showToast(ToastificationType.error,
                                                myProvider.errorMsg);
                                          }
                                          else {
                                            Navigator.pushAndRemoveUntil(
                                                context, MaterialPageRoute(
                                                builder: (context) =>
                                                    MainScreen()), (
                                                route) => false);
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
                        Consumer<LoginProvider>(
                          builder: (_,myProvider, child) =>
                           ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  minimumSize: const Size(double.infinity, 50)),
                              onPressed: () {
                                myProvider.googleSignIn().whenComplete(() {
                                  if (myProvider.isGoogleError) {
                                    showToast(ToastificationType.error,
                                        myProvider.errorMsg);
                                  }
                                  else {
                                    Navigator.pushAndRemoveUntil(
                                        context, MaterialPageRoute(
                                        builder: (context) =>
                                            MainScreen()), (
                                        route) => false);
                                  }
                                },);
                              },
                              child: !myProvider.isGoogleLoading ?
                              const Row(
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
                                    "Login with Google",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              )
                                  :
                              const SpinKitThreeBounce(
                                color: Colors.green,
                                size: 30,
                              )
                           ),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(
                            'Don\'t have an Account? ',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                GlobalMethods().navigateTo(context: context, route: SignUpScreen());
                              },
                              style: TextButton.styleFrom(padding: EdgeInsets.zero),
                              child: const Text(
                                'Sign Up',
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
            )));
    }
  }
