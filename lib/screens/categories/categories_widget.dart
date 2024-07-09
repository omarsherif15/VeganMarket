import 'package:flutter/material.dart';
import 'package:shopmart2/inner_screens/one_category_screen.dart';
import 'package:shopmart2/services/general_methods.dart';

class CategoriesWidget extends StatelessWidget {
   const CategoriesWidget({super.key, required this.catName, required this.imagePath, required this.color});

  final String catName , imagePath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        GlobalMethods().navigateTo(context: context, route: OneCategoryScreen(categoryName: catName.toLowerCase()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Image.asset(imagePath,
               width: 100,
               height: 100,
             ),
            Text(catName)
          ],
        ),
      ),
    );
  }
}
