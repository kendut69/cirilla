library express_checkout;

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'helpers.dart';

const String defaultApplePay = '''{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "__merchantIdentifier__",
    "displayName": "__displayName__",
    "merchantCapabilities": ["3DS", "debit", "credit"],
    "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
    "countryCode": "__countryCode__",
    "currencyCode": "__currencyCode__",
    "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber"],
    "requiredShippingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"] 
  }
}''';

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
  late final Pay _payClient;

  @override
  void initState() {
    String defaultApplePayConfigString = defaultApplePay
        .replaceAll('__merchantIdentifier__', widget.merchantIdentifier)
        .replaceAll('__displayName__', widget.displayName)
        .replaceAll('__countryCode__', widget.countryCode)
        .replaceAll('__currencyCode__', widget.currencyCode);

    _payClient = Pay({
      PayProvider.apple_pay: PaymentConfiguration.fromJsonString(defaultApplePayConfigString),
    });

    super.initState();
  }

  Future<void> onApplePayPressed() async {
    bool canPay = await _payClient.userCanPay(PayProvider.apple_pay);
    debugPrint("canPay: $canPay");
    if (!canPay) return;

    Map<String, dynamic>? cartData = await widget.addToCart();

    if (cartData == null) return;

    // Get unit
    int unit = getUnit(cartData);

    // Get total price
    String total = cartData['totals']['total_price'];

    // Format string 100 to 1.00
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
        label: widget.displayName,
        amount: amount,
        status: PaymentItemStatus.final_price,
        type: PaymentItemType.total,
      )
    ];

    try {
      final result = await _payClient.showPaymentSelector(PayProvider.apple_pay, paymentItems);
      widget.progressCheckout(result);
    } catch (e) {
      widget.progressCheckout({"status": "error"});
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawApplePayButton(
      style: ApplePayButtonStyle.black,
      type: ApplePayButtonType.buy,
      onPressed: onApplePayPressed,
    );
  }
}
