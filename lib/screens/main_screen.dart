
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/consts/consts.dart';
import 'package:shopmart2/provider/dark_theme_provider.dart';
import 'package:shopmart2/screens/cart/cart_screen.dart';
import 'package:shopmart2/screens/categories/categories_screen.dart';
import 'package:shopmart2/screens/home_screen.dart';
import 'package:shopmart2/screens/profile/profile_screen.dart';
import 'package:shopmart2/widgets/badged_cart_icon.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List screens = [
    const HomeScreen(),
    CategoriesScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    themeState.getCustomerData();
    bool isDark = themeState.getDarkTheme();
  return Scaffold(
      body: screens[ themeState.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: themeState.selectedIndex,
        onTap: (index){themeState.selectedScreen(index);},
        selectedItemColor: isDark ? Colors.white : Colors.black,
        unselectedItemColor: isDark ? Colors.white : Colors.black,
        showUnselectedLabels: false,
        items:  [
          const BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(IconlyLight.home)
          ),
          const BottomNavigationBarItem(
              label: 'Categories',
              icon: Icon(IconlyLight.category)
          ),
          BottomNavigationBarItem(
              label: 'My Cart',
              icon: customerModel != null ? BadgedCartIcon(count: customerModel!.currentCartQuantity): const Icon(IconlyLight.buy)),

              //   } else {
              //     return
              //   }
              // })
          const BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(IconlyLight.user2)
          ),
        ],
      ),
    );
  }
}
