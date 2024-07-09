import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/theme_data.dart';
import '../provider/dark_theme_provider.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    required this.icon,
    required this.hint,
    super.key,
    required this.textEditingController,
    required this.validate,
    required this.focusNode,
    required this.gotoFocusNode
  });

  final String hint;
  final Icon icon;
  TextEditingController textEditingController = TextEditingController();
  String? Function(String?) validate;
  FocusNode focusNode, gotoFocusNode;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final themeData = Styles.themeData(themeState.getDarkTheme(), context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        maxLines: 1,
        controller: textEditingController,
        decoration:  InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green)
          ),
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
