import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/consts/consts.dart';
import 'package:shopmart2/consts/theme_data.dart';
import 'package:shopmart2/screens/profile/address_screen/address_screen.dart';
import 'package:shopmart2/screens/profile/orders/orders_screen.dart';
import 'package:shopmart2/screens/profile/wishlist/wishlist_screen.dart';
import 'package:shopmart2/provider/dark_theme_provider.dart';
import 'package:shopmart2/provider/login_provider.dart';
import 'package:shopmart2/provider/signup_provider.dart';
import 'package:shopmart2/screens/boarding/boarding_screen.dart';
import 'package:shopmart2/screens/login/forgetPassword.dart';
import 'package:shopmart2/screens/profile/profile_card.dart';
import 'package:shopmart2/services/general_methods.dart';
import 'package:shopmart2/widgets/fallBack_widget.dart';
import 'package:shopmart2/widgets/warning_dialog.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final signUpProvider = Provider.of<SignupProvider>(context);

    final themeData = Styles.themeData(themeState.getDarkTheme(), context);
    final TextEditingController AddressController = TextEditingController();
    return ChangeNotifierProvider(create: (_) => LoginProvider(),
        child: Consumer<LoginProvider>(builder: (_, myProvider, child) {
      return ConditionalBuilder(
        condition: customerModel != null,
        builder:(context) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            elevation: 15,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Hi,',
                        style: const TextStyle(color: Colors.cyan, fontSize: 25),
                        children: <TextSpan>[
                      TextSpan(
                          text: customerModel!.fullName,
                          style: TextStyle(
                              fontSize: 25,
                              color: themeState.getDarkTheme()
                                  ? Colors.white
                                  : Colors.black))
                    ])),
                Text('${customerModel!.emailAddress}',
                    style: TextStyle(
                        color: themeState.getDarkTheme()
                            ? Colors.white
                            : Colors.black)),
              ],
            ),
          ),
          body: ListView(
            children: [
              GestureDetector(
                onTap: () async {
                  await showAddressDialog(context, themeData, AddressController);
                },
                child: ProfileCard(
                    title: 'Address',
                    subTitle: 'Address 1 ',
                    leading: IconlyLight.user2,
                    onTap: () {
                      GlobalMethods().navigateTo(context: context, route: const AddressScreen());
                    }),
              ),
              ProfileCard(
                  title: 'Orders',
                  leading: IconlyLight.wallet,
                  onTap: () {
                    GlobalMethods()
                        .navigateTo(context: context, route: OrdersScreen());
                  }),
              ProfileCard(
                  title: 'Wishlist',
                  leading: IconlyLight.heart,
                  onTap: () {
                    GlobalMethods().navigateTo(
                        context: context, route: const WishListScreen());
                  }),
              ProfileCard(
                  title: 'Forgot Password',
                  leading: IconlyLight.password,
                  onTap: () {
                    GlobalMethods()
                        .navigateTo(context: context, route: ForgetPassword());
                  }),
              SwitchListTile(
                value: themeState.getDarkTheme(),
                title: Text(
                  themeState.getDarkTheme() ? 'Dark Theme' : 'Light Theme',
                  style: TextStyle(
                      color:
                          themeState.getDarkTheme() ? Colors.white : Colors.black,
                      fontSize: 18),
                ),
                secondary: themeState.getDarkTheme()
                    ? Icon(Icons.dark_mode_outlined,
                        color: themeState.getDarkTheme()
                            ? Colors.white
                            : Colors.black)
                    : Icon(Icons.light_mode_outlined,
                        color: themeState.getDarkTheme()
                            ? Colors.white
                            : Colors.black),
                onChanged: (value) {
                  themeState.setDarkTheme = value;
                },
              ),
              Consumer<SignupProvider>(builder: (_, myProvider, child) {
                return ProfileCard(
                  title: 'Logout',
                  leading: IconlyLight.logout,
                  onTap: () {
                    WarningDialog().showWarningDialog(
                        context: context,
                        msg: 'Sure want to Logout?',
                        title: 'Logout',
                        function: () {
                          signUpProvider.signout().whenComplete(() =>
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const BoardingScreen()),
                                  (route) => false));
                        });
                  },
                );
              })
            ],
          ),
        ),
        fallback:(context) => FallBack(
          buttonTitle: 'Join Now!',
          msg: 'Ops You Don\'t have an Account',
          image: 'assets/random/warning-sign.png',
          onTap: () => GlobalMethods().navigateTo(context: context, route: const BoardingScreen()),
        ),
      );
    }));
  }

  Future<void> showAddressDialog(context, themeData, addressController) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Address',
              style: themeData.textTheme.bodyMedium,
            ),
            actions: [
              TextButton(onPressed: () {}, child: const Text('Update'))
            ],
            content: TextField(
              controller: addressController,
              decoration: InputDecoration(
                  hintText: 'Enter Your Address',
                  hintStyle: themeData.textTheme.bodyMedium),
              maxLines: 5,
            ),
          );
        });
  }
}
