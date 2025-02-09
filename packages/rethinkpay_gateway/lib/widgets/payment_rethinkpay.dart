import 'package:flutter/material.dart';

class PaymentRethinkpay extends StatefulWidget {
  final dynamic data;
  final Widget Function(String url, BuildContext context, {String Function(String url)? customHandle}) webViewGateway;

  const PaymentRethinkpay({Key? key, required this.data, required this.webViewGateway}) : super(key: key);

  @override
  State<PaymentRethinkpay> createState() => _PaymentRethinkpayState();
}

class _PaymentRethinkpayState extends State<PaymentRethinkpay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.data['payment_result']['redirect_url'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: widget.webViewGateway(url, context),
      ),
    );
  }
}
