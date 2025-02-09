library express_checkout;

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'helpers.dart';
import 'dart:convert';

const String defaultGooglePay = '''{
  "provider": "google_pay",
  "data": __data__
}''';

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

  Future<void> onGooglePayPressed() async {
    try {
      Map<String, dynamic>? cartData = await widget.addToCart();

      if (cartData == null) {
        widget.progressCheckout({"status": "error"});
        return;
      }

      List shippingRates = cartData?["shipping_rates"]?[0]["shipping_rates"] ?? [];

      String defaultSelectedOptionId = shippingRates.firstWhere((element) => element["selected"] ?? false == true)?["rate_id"] ?? "";
      List<Map<String, String>> methodOption = shippingRates.map((e) {
        String id = e["rate_id"] ?? "";
        String name = e["name"] ?? "";

        return {
          "id": id,
          "label": name,
        };
      }).toList();
      bool shippingOptionRequired = methodOption.isNotEmpty;

      final Pay _payClient;
      Map<String, dynamic> data = {
        "environment": widget.environment,
        "apiVersion": 2,
        "apiVersionMinor": 0,
        "allowedPaymentMethods": [
          {
            "type": "CARD",
            "tokenizationSpecification": {
              "type": "PAYMENT_GATEWAY",
              "parameters": widget.gatewayParams
            },
            "parameters": {
              "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
              "allowedCardNetworks": ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"],
              "billingAddressRequired": true,
              "billingAddressParameters": {
                "format": "FULL",
                "phoneNumberRequired": true
              }
            }
          }
        ],
        "merchantInfo": {
          "merchantId": widget.merchantId,
          "merchantName": widget.merchantName
        },
        "transactionInfo": {
          "countryCode": widget.countryCode,
          "currencyCode": widget.currencyCode
        },
        "emailRequired": true,
        "shippingAddressRequired": true,
        "shippingAddressParameters": {
          "phoneNumberRequired": true
        },
        "shippingOptionRequired": shippingOptionRequired,
        if (shippingOptionRequired) "shippingOptionParameters": {
          "defaultSelectedOptionId": defaultSelectedOptionId,
          "shippingOptions": methodOption,
        }
      };
      String defaultGooglePayConfigString = defaultGooglePay
          .replaceAll('__data__', json.encode(data));

      _payClient = Pay({
        PayProvider.google_pay: PaymentConfiguration.fromJsonString(defaultGooglePayConfigString),
      });

      bool canPay = await _payClient.userCanPay(PayProvider.google_pay);

      if (!canPay) {
        widget.progressCheckout({"status": "error"});
        return;
      }

      // Get unit
      int unit = getUnit(cartData);

      // Get total price
      String total = cartData['totals']['total_price'];

      // Format price
      String amount = formatPrice(total, unit);

      List<PaymentItem> paymentItems = [
        // Subtotal
        PaymentItem(
          label: 'Subtotal',
          amount: formatPrice(cartData['totals']['total_items'], unit),
          status: PaymentItemStatus.final_price,
        ),
        // Shipping
        if (cartData['totals']['total_shipping'] != null && cartData['totals']['total_shipping'] != '0')
          PaymentItem(
            label: 'Shipping',
            amount: formatPrice(cartData['totals']['total_shipping'], unit),
            status: PaymentItemStatus.final_price,
          ),
        // Coupon
        if (cartData['totals']['total_discount'] != null && cartData['totals']['total_discount'] != '0')
          PaymentItem(
            label: 'Coupon',
            amount: '-${formatPrice(cartData['totals']['total_discount'], unit)}',
            status: PaymentItemStatus.final_price,
          ),
        // Tax
        if (cartData['totals']['total_tax'] != null && cartData['totals']['total_tax'] != '0')
          PaymentItem(
            label: 'Tax',
            amount: formatPrice(cartData['totals']['total_tax'], unit),
            status: PaymentItemStatus.final_price,
          ),
        // Total
        PaymentItem(
          label: widget.merchantName,
          amount: amount,
          status: PaymentItemStatus.final_price,
          type: PaymentItemType.total,
        )
      ];
      final result = await _payClient.showPaymentSelector(PayProvider.google_pay, paymentItems);
      widget.progressCheckout(result);
    } catch (e) {
      widget.progressCheckout({"status": "error"});
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawGooglePayButton(
      type: GooglePayButtonType.pay,
      onPressed: onGooglePayPressed,
    );
  }
}
