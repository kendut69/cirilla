import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

import 'package:usb_serial/usb_serial.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import '../driver_filter.dart';

import "rethinkpay_form_card.dart";
import 'rethinkpay_swipe_card.dart';
import 'payment_rethinkpay.dart';

class RethinkpayGateway extends StatefulWidget {
  final Function checkout;
  final Widget Function(String url, BuildContext context, {String Function(String url)? customHandle}) webViewGateway;

  const RethinkpayGateway({
    Key? key,
    required this.checkout,
    required this.webViewGateway,
  }) : super(key: key);

  @override
  State<RethinkpayGateway> createState() => _RethinkpayGatewayState();
}

class _RethinkpayGatewayState extends State<RethinkpayGateway> {
  bool _loading = false;

  void checkout(BuildContext context, Map<String, String> cardData) async {
    try {
      setState(() {
        _loading = true;
      });
      dynamic res = await widget.checkout([], options: {"card": cardData});

      String url = res['payment_result']['redirect_url'];
      final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: "budplug");

      setState(() {
        _loading = false;
      });

      if (result?.endsWith('succeeded') == true) {
        Navigator.of(context).pop('success');
      }

    } catch (_) {
      setState(() {
        _loading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _RethinkpayStep1(checkout: checkout, loading: _loading);
  }
}

class _RethinkpayStep1 extends StatefulWidget {
  final void Function(BuildContext, Map<String, String>) checkout;
  final bool loading;

  const _RethinkpayStep1({
    Key? key,
    required this.checkout,
    this.loading = false,
  }) : super(key: key);

  @override
  State<_RethinkpayStep1> createState() => _RethinkpayStep1State();
}

class _RethinkpayStep1State extends State<_RethinkpayStep1> {
  bool _showForm = true;
  bool _loading = false;
  String? _error = null;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _getDevices();
    }
  }

  Future<void> _getDevices() async {
    try {
      setState(() {
        _loading = true;
      });
      List<UsbDevice> devices = await UsbSerial.listDevices();
      setState(() {
        _showForm = devices.isEmpty ? true : devices.any((UsbDevice device) {
          return driverFilter.indexWhere((Map<String, dynamic> it) {
            return device.vid == it["vid"] && device.pid == it["pid"];
          }) != -1;
        });
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        body: Center(
          child: CupertinoActivityIndicator(radius: 16),
        ),
      );
    }

    if (_error?.isNotEmpty == true) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        body: Center(child: Text(_error!)),
      );
    }

    if (_showForm) {
      return RethinkpayFormCard(checkout: widget.checkout, loading: widget.loading);
    }

    return RethinkpaySwipeCard(checkout: widget.checkout, loading: widget.loading);
  }
}
