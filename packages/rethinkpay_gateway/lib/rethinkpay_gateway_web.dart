library rethinkpay_gateway;

import 'package:flutter/widgets.dart';
import 'package:payment_base/payment_base.dart';
import 'widgets/payment_rethinkpay.dart';
import 'widgets/rethinkpay.dart';

class RethinkpayGatewayWeb implements PaymentBase {
  /// Payment method key
  ///
  static const key = "rethink_payment_v1";

  @override
  String get libraryName => "rethinkpay_gateway";

  @override
  String get logoPath => "assets/images/rethinkpay.png";

  @override
  Future<void> initialized({
    required BuildContext context,
    required RouteTransitionsBuilder slideTransition,
    required Function checkout,
    required Function(dynamic data) callback,
    required String amount,
    required String currency,
    required Map<String, dynamic> billing,
    required Map<String, dynamic> settings,
    required Future<dynamic> Function({String? cartKey, required Map<String, dynamic> data}) progressServer,
    required String cartId,
    required Widget Function(String url, BuildContext context, {String Function(String url)? customHandle})
    webViewGateway,
  }) async {
    try {
      dynamic data = await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) => RethinkpayGateway(
            checkout: checkout,
            webViewGateway: webViewGateway,
          ),
          transitionsBuilder: slideTransition,
        ),
      );
      callback(data != null ? "success" : PaymentException(error: "Cancel payment"));
    } catch (e) {
      callback(e);
    }
  }

  @override
  String getErrorMessage(Map<String, dynamic>? error) {
    if (error == null) {
      return 'Something wrong in checkout!';
    }

    return 'Error!';
  }
}
