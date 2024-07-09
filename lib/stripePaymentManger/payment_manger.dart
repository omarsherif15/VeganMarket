import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shopmart2/stripePaymentManger/stripe_keys.dart';

abstract class  PaymentManger {

  static Future<void> stripePayment (int amount, String currency) async {
    try{
      String clientSecret = await _getClientSecret((amount*100).toString(), currency);
      await _initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();
    }
    on StripeConfigException catch (error){
      throw Exception(error.message);
    }
  }

  static Future<void> _initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Vegan Market',
          billingDetails: const BillingDetails(
            email: 'OmarSherifMetwaly@gmail.com',
            name: 'Omar Sherif',
            phone: '01010387741'
          ),
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(

            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance()
          )
        )
    );
  }

  static Future<String> _getClientSecret (String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization' : 'Bearer ${ApiKeys.secretKey}',
          'content-Type' : 'application/x-www-form-urlencoded'
        }
      ),
      data: {
        'amount' : amount,
        'currency' : currency
      }
    );
    return response.data['client_secret'];
  }
}