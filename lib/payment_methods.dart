import 'package:cirilla/screens/checkout/gateway/gateway.dart';
import 'package:flutter/material.dart';
import 'package:payment_base/payment_base.dart';

final Map<String, PaymentBase> methods = {
  ChequeGateway.key: ChequeGateway(),
  CodGateway.key: CodGateway(),
  BacsGateway.key: BacsGateway(),
  'sumo_payment_plans': SumoPaymentPlansGateway(),
};

class SumoPaymentPlansGateway extends PaymentBase {
  @override
  Future<void> initialized({
    required BuildContext context,
    required Future<dynamic> Function(List<dynamic>,
            {Map<String, dynamic>? billingOptions,
            Map<String, dynamic>? options,
            Map<String, dynamic>? shippingOptions})
        checkout,
    required Function(dynamic data) callback,
    required String amount,
    required String currency,
    required Map<String, dynamic> billing,
    required Map<String, dynamic> settings,
    required String cartId,
    required Future<dynamic> Function(
            {String? cartKey, required Map<String, dynamic> data})
        progressServer,
    required Widget Function(
            BuildContext, Animation<double>, Animation<double>, Widget)
        slideTransition,
    required Widget Function(String url, BuildContext context,
            {String Function(String)? customHandle})
        webViewGateway,
  }) async {
    try {
      List<dynamic> paymentData = [
        {"payment_method": "sumo_payment_plans"}
      ];

      await checkout(
        paymentData,
        billingOptions: billing,
      );

      callback({"redirect": "order"});
    } catch (e) {
      callback(e);
    }
  }

  @override
  String getErrorMessage(Map<String, dynamic>? error) {
    // TODO: implement getErrorMessage
    throw UnimplementedError();
  }
}
