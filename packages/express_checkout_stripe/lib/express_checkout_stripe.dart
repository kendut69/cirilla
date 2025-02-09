library express_checkout_stripe;

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:express_checkout/express_checkout.dart' as express_checkout;
import 'package:flutter_stripe/flutter_stripe.dart';

class ExpressApplePayButton extends StatefulWidget {
  final String merchantIdentifier;
  final String countryCode;
  final String displayName;
  final String currencyCode;
  final Future<Map<String, dynamic>?> Function() addToCart;
  final void Function(Map<String, dynamic> paymentResult) progressCheckout;

  const ExpressApplePayButton({
    super.key,
    required this.merchantIdentifier,
    required this.countryCode,
    required this.displayName,
    required this.currencyCode,
    required this.addToCart,
    required this.progressCheckout,
  });

  @override
  State<ExpressApplePayButton> createState() => _ExpressApplePayButtonState();
}

class _ExpressApplePayButtonState extends State<ExpressApplePayButton> {

  @override
  void initState() {
    Stripe.publishableKey =
    'pk_test_51KVu8PApnLDXBKPzv1vgOu13kcucHvrd6FyoTZI4x2W6qDcNYFfHwMof8pbrBnbQLVcxQH5beUMw2cyD69Gd0PBP00jdx8n558';
    super.initState();
  }

  Future<void> onApplePayPressed(paymentResult) async {
    try {
      if (paymentResult['status'] == 'error') {
        widget.progressCheckout(paymentResult);
        return;
      }

      await Stripe.instance.applySettings();
      final token = await Stripe.instance.createApplePayToken(paymentResult);
      paymentResult['stripe_token'] = token.id;
      widget.progressCheckout(paymentResult);
    } catch (e) {
      widget.progressCheckout({"status": "error"});
    }
  }

  @override
  Widget build(BuildContext context) {
    return express_checkout.ExpressApplePayButton(
      countryCode: widget.countryCode,
      currencyCode: widget.currencyCode,
      displayName: widget.displayName,
      merchantIdentifier: widget.merchantIdentifier,
      addToCart: widget.addToCart,
      progressCheckout: onApplePayPressed,
    );
  }
}

class ExpressGooglePayButton extends StatefulWidget {
  final String environment;
  final String merchantId;
  final String merchantName;
  final Map<String, String> gatewayParams;
  final String countryCode;
  final String currencyCode;
  final Future<Map<String, dynamic>?> Function() addToCart;
  final void Function(Map<String, dynamic> paymentResult) progressCheckout;

  const ExpressGooglePayButton({
    super.key,
    required this.environment,
    required this.merchantId,
    required this.merchantName,
    required this.gatewayParams,
    required this.countryCode,
    required this.currencyCode,
    required this.addToCart,
    required this.progressCheckout,
  });

  @override
  State<ExpressGooglePayButton> createState() => _ExpressGooglePayButtonState();
}

class _ExpressGooglePayButtonState extends State<ExpressGooglePayButton> {

  @override
  void initState() {
    Stripe.publishableKey =
    'pk_test_51KVu8PApnLDXBKPzv1vgOu13kcucHvrd6FyoTZI4x2W6qDcNYFfHwMof8pbrBnbQLVcxQH5beUMw2cyD69Gd0PBP00jdx8n558';
    super.initState();
  }

  Future<void> onGooglePayPressed(paymentResult) async {
    try {
      if (paymentResult['status'] == 'error') {
        widget.progressCheckout(paymentResult);
        return;
      }
      await Stripe.instance.applySettings();
      final token = paymentResult['paymentMethodData']['tokenizationData']['token'];
      final tokenJson = Map.castFrom(json.decode(token));
      paymentResult['stripe_token'] = tokenJson['id'];
      widget.progressCheckout(paymentResult);
    } catch (e) {
      widget.progressCheckout({"status": "error"});
    }
  }

  @override
  Widget build(BuildContext context) {
    return express_checkout.ExpressGooglePayButton(
      countryCode: widget.countryCode,
      currencyCode: widget.currencyCode,
      environment: widget.environment,
      merchantId: widget.merchantId,
      merchantName: widget.merchantName,
      gatewayParams: widget.gatewayParams,
      addToCart: widget.addToCart,
      progressCheckout: onGooglePayPressed,
    );
  }
}
