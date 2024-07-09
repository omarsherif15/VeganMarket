
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/productsModel/products_model.dart';

class ProductsProvider with ChangeNotifier {

  List<ProductModel> newProductsList = [];
  // List<ProductModel> get getProducts {
  //   return _productsList;
  // }

  bool isListLoading = false;

  void getProducts() async {
    isListLoading = true;
    notifyListeners();
    try {
      await FirebaseFirestore.instance
          .collection('Products')
          .get()
          .then((onValue) {
        onValue.docs.forEach((element) async {
          newProductsList.add(ProductModel.fromJson(element.data()));
        });
        print(newProductsList[0].title);
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
    print(newProductsList[0].title);
    notifyListeners();
  }

  List<ProductModel> productOnSale = [];
  void getSaleProducts (){
    productOnSale = [];
    for (var element in newProductsList) {
      if(element.isOnSale) {
        productOnSale.add(element);
        print(element.title);
        print('mmmmmmmmmmmmmmmmmmmmmmm');
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

  // static final List<ProductModel> _productsList = [
  //   ProductModel(
  //     id: 'Apricot',
  //     title: 'Apricot',
  //     price: 0.99,
  //     salePrice: 0.49,
  //     imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: true,
  //   ),
  //   ProductModel(
  //     id: 'Avocado',
  //     title: 'Avocado',
  //     price: 0.88,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/9VKXw5L/Avocat.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: false,
  //   ),
  //   ProductModel(
  //     id: 'Black grapes',
  //     title: 'Black grapes',
  //     price: 1.22,
  //     salePrice: 0.7,
  //     imageUrl: 'https://i.ibb.co/c6w5zrC/Black-Grapes-PNG-Photos.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: true,
  //   ),
  //   ProductModel(
  //     id: 'Fresh_green_grape',
  //     title: 'Fresh green grape',
  //     price: 1.5,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/HKx2bsp/Fresh-green-grape.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: true,
  //   ),
  //   ProductModel(
  //     id: 'Green grape',
  //     title: 'Green grape',
  //     price: 0.99,
  //     salePrice: 0.4,
  //     imageUrl: 'https://i.ibb.co/bHKtc33/grape-green.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: false,
  //   ),
  //   ProductModel(
  //     id: 'Red apple',
  //     title: 'Red apple',
  //     price: 0.6,
  //     salePrice: 0.2,
  //     imageUrl: 'https://i.ibb.co/crwwSG2/red-apple.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: true,
  //   ),
  //   // Vegi
  //   ProductModel(
  //     id: 'Carottes',
  //     title: 'Carottes',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/TRbNL3c/Carottes.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: true,
  //   ),
  //   ProductModel(
  //     id: 'Cauliflower',
  //     title: 'Cauliflower',
  //     price: 1.99,
  //     salePrice: 0.99,
  //     imageUrl: 'https://i.ibb.co/xGWf2rH/Cauliflower.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //
  //   ),
  //   ProductModel(
  //     id: 'Cucumber',
  //     title: 'Cucumber',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/kDL5GKg/cucumbers.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //   ),
  //   ProductModel(
  //     id: 'Jalape',
  //     title: 'Jalape',
  //     price: 1.99,
  //     salePrice: 0.89,
  //     imageUrl: 'https://i.ibb.co/Dtk1YP8/Jalape-o.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //   ),
  //   ProductModel(
  //     id: 'Long yam',
  //     title: 'Long yam',
  //     price: 2.99,
  //     salePrice: 1.59,
  //     imageUrl: 'https://i.ibb.co/V3MbcST/Long-yam.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //   ),
  //   ProductModel(
  //     id: 'Onions',
  //     title: 'Onions',
  //     price: 0.59,
  //     salePrice: 0.28,
  //     imageUrl: 'https://i.ibb.co/GFvm1Zd/Onions.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //   ),
  //   ProductModel(
  //     id: 'Plantain-flower',
  //     title: 'Plantain-flower',
  //     price: 0.99,
  //     salePrice: 0.389,
  //     imageUrl: 'https://i.ibb.co/RBdq0PD/Plantain-flower.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //
  //   ),
  //   ProductModel(
  //     id: 'Potato',
  //     title: 'Potato',
  //     price: 0.99,
  //     salePrice: 0.59,
  //     imageUrl: 'https://i.ibb.co/wRgtW55/Potato.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: true,
  //   ),
  //   ProductModel(
  //     id: 'Radish',
  //     title: 'Radish',
  //     price: 0.99,
  //     salePrice: 0.79,
  //     imageUrl: 'https://i.ibb.co/YcN4ZsD/Radish.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //   ),
  //   ProductModel(
  //     id: 'Red peppers',
  //     title: 'Red peppers',
  //     price: 0.99,
  //     salePrice: 0.57,
  //     imageUrl: 'https://i.ibb.co/JthGdkh/Red-peppers.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //   ),
  //   ProductModel(
  //     id: 'Squash',
  //     title: 'Squash',
  //     price: 3.99,
  //     salePrice: 2.99,
  //     imageUrl: 'https://i.ibb.co/p1V8sq9/Squash.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: true,
  //
  //   ),
  //   ProductModel(
  //     id: 'Tomatoes',
  //     title: 'Tomatoes',
  //     price: 0.99,
  //     salePrice: 0.39,
  //     imageUrl: 'https://i.ibb.co/PcP9xfK/Tomatoes.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: true,
  //   ),
  //   // Grains
  //   ProductModel(
  //     id: 'Corn-cobs',
  //     title: 'Corn-cobs',
  //     price: 0.29,
  //     salePrice: 0.19,
  //     imageUrl: 'https://i.ibb.co/8PhwVYZ/corn-cobs.png',
  //     productCategoryName: 'Grains',
  //     isOnSale: false,
  //
  //   ),
  //   ProductModel(
  //     id: 'Peas',
  //     title: 'Peas',
  //     price: 0.99,
  //     salePrice: 0.49,
  //     imageUrl: 'https://i.ibb.co/7GHM7Dp/peas.png',
  //     productCategoryName: 'Grains',
  //     isOnSale: false,
  //   ),
  //   // Herbs
  //   ProductModel(
  //     id: 'Asparagus',
  //     title: 'Asparagus',
  //     price: 6.99,
  //     salePrice: 4.99,
  //     imageUrl: 'https://i.ibb.co/RYRvx3W/Asparagus.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: false,
  //   ),
  //   ProductModel(
  //     id: 'Brokoli',
  //     title: 'Brokoli',
  //     price: 0.99,
  //     salePrice: 0.89,
  //     imageUrl: 'https://i.ibb.co/KXTtrYB/Brokoli.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: true,
  //
  //   ),
  //   ProductModel(
  //     id: 'Buk-choy',
  //     title: 'Buk-choy',
  //     price: 1.99,
  //     salePrice: 0.99,
  //     imageUrl: 'https://i.ibb.co/MNDxNnm/Buk-choy.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: true,
  //
  //   ),
  //   ProductModel(
  //     id: 'Chinese-cabbage-wombok',
  //     title: 'Chinese-cabbage-wombok',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/7yzjHVy/Chinese-cabbage-wombok.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: false,
  //
  //   ),
  //   ProductModel(
  //     id: 'Kangkong',
  //     title: 'Kangkong',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/HDSrR2Y/Kangkong.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: false,
  //
  //   ),
  //   ProductModel(
  //     id: 'Leek',
  //     title: 'Leek',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/Pwhqkh6/Leek.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: false,
  //
  //   ),
  //   ProductModel(
  //     id: 'Spinach',
  //     title: 'Spinach',
  //     price: 0.89,
  //     salePrice: 0.59,
  //     imageUrl: 'https://i.ibb.co/bbjvgcD/Spinach.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: true,
  //
  //   ),
  //   ProductModel(
  //     id: 'Almond',
  //     title: 'Almond',
  //     price: 8.99,
  //     salePrice: 6.5,
  //     imageUrl: 'https://i.ibb.co/c8QtSr2/almand.jpg',
  //     productCategoryName: 'Nuts',
  //     isOnSale: true,
  //   ),
  // ];
}
