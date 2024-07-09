import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../../provider/login_provider.dart';
import '../../widgets/show_toast.dart';
import '../../widgets/text_field_widget.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  var forgotPasswordFormKey = GlobalKey<FormState>();
  FocusNode emailFocus = FocusNode();
  TextEditingController emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginProvider(),
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Please enter the email assigned to your account',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: forgotPasswordFormKey,
                  child: MyTextField(
                    icon: const Icon(
                      IconlyBroken.message,
                      color: Colors.green,
                    ),
                    hint: 'Email Address',
                    textEditingController: emailTextController,
                    focusNode: emailFocus,
                    gotoFocusNode: emailFocus,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Email Address must be filled';
                      } else if (!value.contains('@')) {
                        return 'Please enter valid Email Address';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<LoginProvider>(
                  builder: (_, myProvider, child) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(double.infinity, 50)),
                      onPressed: () {
                        if (forgotPasswordFormKey.currentState!.validate()) {
                          myProvider
                              .forgetPassword(
                                  emailTextController.text.toLowerCase())
                              .whenComplete(() {
                            if (myProvider.isForgetPasswordError) {
                              showToast(ToastificationType.error,
                                  myProvider.errorMsg);
                            }
                            else {
                              showToast(ToastificationType.success, 'Password reset link was sent to ${emailTextController.text} ');
                            }
                          });
                        }
                      },
                      child: !myProvider.isForgetPasswordLoading ?
                      const Text(
                        "Reset Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                          :
                      const SpinKitThreeBounce(
                        color: Colors.white,
                        size: 30,
                      )
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
