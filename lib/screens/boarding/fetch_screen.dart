import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopmart2/provider/dark_theme_provider.dart';
import 'package:shopmart2/provider/order_provider.dart';
import 'package:shopmart2/screens/main_screen.dart';



class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 5), () async {
      final themeState = Provider.of<DarkThemeProvider>(context, listen: false);
      await themeState.getCustomerData();
      final orders = Provider.of<OrdersProvider>(context, listen: false);
      await orders.getMyOrders();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) =>  MainScreen(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/vegan_logo.png',
            fit: BoxFit.contain,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
