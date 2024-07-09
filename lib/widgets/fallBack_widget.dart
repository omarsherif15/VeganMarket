import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/theme_data.dart';
import '../provider/dark_theme_provider.dart';

class FallBack extends StatelessWidget {
  FallBack ({super.key, required this.msg, required this.image, required this.buttonTitle, required this.onTap});
  String msg, image, buttonTitle;
  void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final themeData = Styles.themeData(themeState.getDarkTheme(), context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage(image),height: 250, width: 250,),
                const SizedBox(height: 10,),
                const Text('Whoops', style: TextStyle(fontSize: 29,fontWeight: FontWeight.bold,color: Colors.red)),
                const SizedBox(height: 10,),
                Text(msg, style: themeData.textTheme.bodyMedium,textAlign: TextAlign.center,),
                const Spacer(),
                OutlinedButton(
                  onPressed: onTap,
                  style: OutlinedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width*0.38,50),
                      backgroundColor: themeData.scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                  ),
                  child: Text(buttonTitle,style: themeData.textTheme.bodyMedium),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
