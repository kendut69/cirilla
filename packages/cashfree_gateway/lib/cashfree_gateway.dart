library cashfree_gateway;

import 'package:flutter/material.dart';
import 'package:payment_base/payment_base.dart';

import 'widgets/cashfree_screen.dart';

/// A Calculator.
class CashfreeGateway implements PaymentBase {
  /// Payment method key
  ///
  static const key = "cashfree";
  @override
  String get libraryName => "cashfree_gateway";

  @override
  String get logoPath => 'assets/images/cashfree_logo.png';

  final Function(BuildContext context, {String? price, String? currency, String? symbol, String? pattern})
      formatCurrency;
  CashfreeGateway({
    required this.formatCurrency,
  });

  @override
  Future<void> initialized({
    required BuildContext context,
    required RouteTransitionsBuilder slideTransition,
    required Future Function(List p1) checkout,
    required Function(dynamic data) callback,
    required String amount,
    required String currency,
    required Map<String, dynamic> billing,
    required Map<String, dynamic> settings,
    required Future Function({String? cartKey, required Map<String, dynamic> data}) progressServer,
    required String cartId,
    required Widget Function(String url, BuildContext context, {String Function(String url)? customHandle})
        webViewGateway,
  }) async {
    dynamic checkoutData;
    try {
      checkoutData = await checkout([]);
    } catch (e) {
      callback(e);
      return;
    }
    if (context.mounted) {
      final result = await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) => CashfreeNativeScreen(
            checkoutData: checkoutData,
            amount: amount,
            currency: currency,
            callback: callback,
            formatCurrency: formatCurrency,
            webViewGateway: webViewGateway,
          ),
          transitionsBuilder: slideTransition,
        ),
      );
      if (result != null) {
        await progressServer(
          data: {
            'cart_key': cartId,
            'action': 'clean',
          },
          cartKey: cartId,
        );
        callback([]);
      }
    }
  }

  @override
  String getErrorMessage(Map<String, dynamic>? error) {
    if (error == null) {
      return 'Something wrong in checkout!';
    }

    if (error['message'] != null) {
      return error['message'];
    }
    return 'Error!';
  }
}
