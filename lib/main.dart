import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/consts/consts.dart';
import 'package:shopmart2/consts/theme_data.dart';
import 'package:shopmart2/provider/cart_provider.dart';
import 'package:shopmart2/provider/dark_theme_provider.dart';
import 'package:shopmart2/provider/order_provider.dart';
import 'package:shopmart2/provider/products_provider.dart';
import 'package:shopmart2/provider/signup_provider.dart';
import 'package:shopmart2/provider/wishList_provider.dart';
import 'package:shopmart2/screens/boarding/splash_screen.dart';
import 'package:shopmart2/screens/main_screen.dart';
import 'package:shopmart2/stripePaymentManger/stripe_keys.dart';
import 'package:toastification/toastification.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = ApiKeys.publishableKey;
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyBQg2x515_ZE4es_M7qHBlZAJHoiIklSRA',
        messagingSenderId: '',
        projectId: 'vegan-market-1d92d',
        appId: '1:758887531690:android:22b8166a6164a10902fcd3',
    )
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {

  DarkThemeProvider themeChangerProvider =  DarkThemeProvider();
  void getCurrentThemeData() async {
    themeChangerProvider.setDarkTheme = await themeChangerProvider.darkThemePrefs.getThemeData();
    await themeChangerProvider.getCustomerData();

  }

  @override
  void initState() {
    themeChangerProvider.getCustomerData();
    getCurrentThemeData();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_){
          return DarkThemeProvider()..getCustomerData();
    }),
        ChangeNotifierProvider(create: (_){
          return ProductsProvider()..getProducts()..getSaleProducts();
        }),
        ChangeNotifierProvider(create: (_){
          return CartProvider() ;
        }),
        ChangeNotifierProvider(create: (_){
          return WishlistProvider()..getWishListItems(currentCustomerUID) ;
        }),
        ChangeNotifierProvider(create: (_){
          return SignupProvider() ;
        }),
        ChangeNotifierProvider(create: (_){
          return OrdersProvider()..getMyOrders() ;
        }),
      ],
        child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return ToastificationWrapper(
            child: MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(themeProvider.getDarkTheme(), context),
              home:  const SplashScreen()
            ),
          );
        }
      ),
    );
  }
}
