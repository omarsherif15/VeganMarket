import 'package:flutter/material.dart';

class WarningDialog {
  Future<void> showWarningDialog({required context, required msg, required title, required void Function() function}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(right: 20, left:20, top: 12),
              title: Row(
                children: [
                  const Image(image: AssetImage('assets/random/warning-sign.png'),height: 25,width: 25,fit: BoxFit.cover,),
                  const SizedBox(width: 5,),
                  Text(title),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No')
                ),
                TextButton(
                    onPressed: function,
                    child: const Text('Yes')
                )
              ],
              content: const Text('Are You Sure?')
          );
        }
    );
  }
}