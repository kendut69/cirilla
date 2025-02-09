import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usb_serial/usb_serial.dart';
import '../helpers/card_data.dart';

class SwipeCard extends StatefulWidget {
  final void Function(BuildContext, Map<String, String>) checkout;
  final bool loading;

  const SwipeCard({
    Key? key,
    required this.checkout,
    this.loading = false,
  }) : super(key: key);

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      /// Update only if this widget initialized.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        String text = _controller.text;
        if (!widget.loading && text.endsWith("?")) {
          Map<String, String> data = parseCardData(text);
          data["brand"] = getCardBrand(data["number"] ?? "");
          _controller.clear();
          widget.checkout(context, data);
        }
      });
    });
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF57c2bb),
      body: Stack(
        children: [
          Positioned(
            child: Opacity(
              opacity: 0,
              child: TextFormField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(labelText: "Input"),
              ),
            ),
          ),
          Center(
            child: Image.asset("assets/images/wait_swipe_card.gif", package: "poskick_gateway", width: 300),
          ),
          if (widget.loading)
            const Positioned.fill(
              child: Center(
                child: CupertinoActivityIndicator(radius: 25),
              ),
            ),
        ],
      ),
    );
  }
}
