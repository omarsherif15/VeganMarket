import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/theme_data.dart';
import '../provider/dark_theme_provider.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    this.icon,
    required this.hint,
    super.key,
    required this.textEditingController,
    required this.validate,
    this.focusNode,
    this.gotoFocusNode,
    this.decoration,
    this.padding = 15,
    this.maxLines = 1
  });

  final String hint;
  final Icon? icon;
  TextEditingController textEditingController = TextEditingController();
  String? Function(String?) validate;
  FocusNode? focusNode, gotoFocusNode;
  InputBorder? decoration = const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey)
  );
  double padding = 15;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final themeData = Styles.themeData(themeState.getDarkTheme(), context);
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: padding),
      child: TextFormField(
        maxLines: maxLines,
        controller: textEditingController,
        decoration:  InputDecoration(
          enabledBorder: decoration,
          focusedBorder: decoration,
          hintText: hint,
          prefixIcon: icon,
          focusColor: Colors.green,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => FocusScope.of(context).requestFocus(gotoFocusNode),
        cursorColor: Colors.green,
        validator: validate,
      ),
    );
  }
}
