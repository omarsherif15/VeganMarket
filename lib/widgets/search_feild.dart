import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration:  InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.white,
          hintText: 'Search All Products',
          suffixIcon: const Icon(Icons.search,size: 35,)
      ),

      // ),
    );
  }
}
