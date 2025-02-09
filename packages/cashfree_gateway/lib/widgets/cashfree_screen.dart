import 'package:cashfree_gateway/utils/helper.dart';
import 'package:flutter/material.dart';
import 'cashfree_checkout.dart';

class CashfreeNativeScreen extends StatefulWidget {
  final Map<String, dynamic> checkoutData;
  final Function(dynamic data) callback;
  final String amount;
  final String currency;
  final Function(BuildContext context, {String? price, String? currency, String? symbol, String? pattern})
      formatCurrency;
  final Widget Function(String url, BuildContext context, {String Function(String url)? customHandle}) webViewGateway;
  const CashfreeNativeScreen({
    super.key,
    required this.checkoutData,
    required this.callback,
    required this.amount,
    required this.currency,
    required this.formatCurrency,
    required this.webViewGateway,
  });
  @override
  State<CashfreeNativeScreen> createState() => CashfreeNativeScreenState();
}

class CashfreeNativeScreenState extends State<CashfreeNativeScreen> {
  void webCheckout() async {
    String url = getData(widget.checkoutData, ['payment_result', 'redirect_url'], "");
    if (mounted && url != "") {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CashfreeCheckout(
            webViewGateway: widget.webViewGateway,
            url: url,
          ),
        ),
      );
      if (result != null && mounted) {
        Navigator.of(context).pop(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String amount = widget.formatCurrency(context, price: widget.amount);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.chevron_left_rounded, size: 30),
            ),
            centerTitle: true,
            title: const Text('Pay for order'),
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                buildItem(
                  title: "ORDER NUMBER:",
                  value: "${getData(widget.checkoutData, ["order_id"], "")}",
                ),
                buildItem(
                  title: "STATUS:",
                  value: "${getData(widget.checkoutData, ["status"], "")}",
                ),
                buildItem(
                  title: "TOTAL:",
                  value: amount,
                ),
                buildItem(
                  title: "PAYMENT METHOD:",
                  value: "${getData(widget.checkoutData, ["payment_method"], "")} payments",
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: webCheckout,
                      child: const Text("Payment"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItem({required String title, required String value}) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(value, style: textTheme.titleMedium),
        Divider(color: theme.colorScheme.onSurface, thickness: 0.2, height: 19),
      ],
    );
  }
}
