import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPay {
  final _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // payment success logic
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // payment failure logic
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // external wallet logic
  }
  void _startPayment() {
    var options = {
      'key': '<YOUR_KEY_ID>',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Test Payment',
      'prefill': {'contact': '9999999999', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
}
