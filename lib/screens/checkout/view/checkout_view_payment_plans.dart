import 'package:flutter/material.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/types/types.dart';
import 'package:provider/provider.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:sumo_payment_plans/models/payment_plan.dart';
import 'package:sumo_payment_plans/services/sumo_payment_service.dart';

class CheckoutViewPaymentPlans extends StatefulWidget {
  final CartStore cartStore;

  const CheckoutViewPaymentPlans({
    Key? key,
    required this.cartStore,
  }) : super(key: key);

  @override
  State<CheckoutViewPaymentPlans> createState() =>
      _CheckoutViewPaymentPlansState();
}

class _CheckoutViewPaymentPlansState extends State<CheckoutViewPaymentPlans> {
  late SumoPaymentService _paymentService;
  PaymentPlan? _paymentPlan;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initPaymentService();
    _loadPaymentPlan();
  }

  void _initPaymentService() {
    SettingStore settingStore =
        Provider.of<SettingStore>(context, listen: false);
    _paymentService = SumoPaymentService(
      baseUrl: settingStore.domain,
      customerKey: '', customerSecret: '', // TODO: Implement nonce retrieval
    );
  }

  Future<void> _loadPaymentPlan() async {
    try {
      final plan = await _paymentService.getCartPaymentPlan();
      setState(() {
        _paymentPlan = plan;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('Error loading payment plan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_paymentPlan == null ||
        (!_paymentPlan!.orderPaymentplanEnabled &&
            !_paymentPlan!.productPaymentplanEnabled)) {
      return const SizedBox();
    }

    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translate('checkout_payment_plan'),
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (_paymentPlan!.orderPaymentplanEnabled) ...[
              Text(
                translate('checkout_order_payment_plan'),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(translate('checkout_down_payment')),
                  Text(_paymentPlan!.orderPaymentplanTotals.downPayment),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(translate('checkout_total_payable')),
                  Text(_paymentPlan!.orderPaymentplanTotals.totalPayableAmount),
                ],
              ),
              const SizedBox(height: 8),
              Text(_paymentPlan!.orderPaymentplanFuturePaymentsInfo),
            ],
            if (_paymentPlan!.productPaymentplanEnabled) ...[
              if (_paymentPlan!.orderPaymentplanEnabled)
                const Divider(height: 24),
              Text(
                translate('checkout_product_payment_plan'),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(_paymentPlan!.productPaymentplanFuturePaymentsInfo),
            ],
          ],
        ),
      ),
    );
  }
}
