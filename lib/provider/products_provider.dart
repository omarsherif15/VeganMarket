
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/productsModel/products_model.dart';

class ProductsProvider with ChangeNotifier {

  List<ProductModel> newProductsList = [];
  bool isListLoading = false;

  Future<void> getProducts() async {
    isListLoading = true;
    notifyListeners();
    try {
      newProductsList = [];
      await FirebaseFirestore.instance
          .collection('Products')
          .get()
          .then((onValue) {
        onValue.docs.forEach((element) async {
          newProductsList.add(ProductModel.fromJson(element.data()));
        });
        notifyListeners();
      });
      isListLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      print(error.message);
      isListLoading = false;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      isListLoading = false;
      notifyListeners();
    }
    isListLoading = false;
    notifyListeners();
  }

  List<ProductModel> productOnSale = [];
  void getSaleProducts (){
    productOnSale = [];
    for (var element in newProductsList) {
      if(element.isOnSale) {
        productOnSale.add(element);
      }
    }
    notifyListeners();
  }

  bool productLoading = false;
  ProductModel? findProductById (String? productId) {
    for (int i = 0 ; i <= newProductsList.length ; i++) {
      if(newProductsList[i].id == productId){
        return newProductsList[i];
      }
    }
       notifyListeners();
       return null;
  }

  List <ProductModel> findProductByCategory (String categoryName){
    return newProductsList.where((element) => element.productCategoryName.toLowerCase() == categoryName).toList();
  }
}
