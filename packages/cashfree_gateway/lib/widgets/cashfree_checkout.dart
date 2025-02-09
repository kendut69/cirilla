import 'package:flutter/material.dart';

class CashfreeCheckout extends StatefulWidget {
  final String url;
  final Widget Function(String url, BuildContext context, {String Function(String url)? customHandle}) webViewGateway;
  const CashfreeCheckout({
    Key? key,
    required this.url,
    required this.webViewGateway,
  }) : super(key: key);

  @override
  State<CashfreeCheckout> createState() => _CashfreeCheckoutState();
}

class _CashfreeCheckoutState extends State<CashfreeCheckout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.chevron_left_rounded, size: 30),
        ),
        title: const Text('Cashfree Checkout'),
        centerTitle: true,
        elevation: 0,
      ),
      body: widget.webViewGateway(widget.url, context),
    );
  }
}
