import 'package:flutter/material.dart';
import 'package:shopmart2/screens/categories/categories_widget.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({super.key});

  List<Color> gridColor = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.deepOrange,
    Colors.deepPurpleAccent,
    Colors.pink
  ];
  List<Map<String, dynamic>> categoryInfo = [
    {
      'imagePath': 'assets/categories/fruits.png',
      'catName': 'Fruits'
    },
    {
      'imagePath': 'assets/categories/veg.png',
      'catName'   : 'Vegetables',
    },
    {
      'imagePath': 'assets/categories/Spinach.png',
      'catName'   : 'Herbs',
    },
    {
      'imagePath': 'assets/categories/nuts.png',
      'catName'   : 'Nuts',
    },
    {
      'imagePath': 'assets/categories/spices.png',
      'catName'   : 'Spices',
    },
    {
      'imagePath': 'assets/categories/grains.png',
      'catName'   : 'Grains',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Categories'),
        ),
        body: GridView.count(
            crossAxisCount: 2,
          padding: const EdgeInsets.all(15),
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: List.generate(
              6, (index) =>
              CategoriesWidget(
                  color: gridColor[index],
                  catName: categoryInfo[index]['catName'],
                  imagePath: categoryInfo[index]['imagePath'],
          )
          )
        ),
      )
    );
  }
}
