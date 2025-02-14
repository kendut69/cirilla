import 'package:flutter/material.dart';
import '../models/payment_plan.dart';

class PaymentPlanWidget extends StatelessWidget {
  final PaymentPlan paymentPlan;

  const PaymentPlanWidget({
    Key? key,
    required this.paymentPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!paymentPlan.orderPaymentplanEnabled &&
        !paymentPlan.productPaymentplanEnabled) {
      return const SizedBox();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (paymentPlan.orderPaymentplanEnabled) ...[
              Text(
                'Order Payment Plan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                  'Down Payment: ${paymentPlan.orderPaymentplanTotals.downPayment}'),
              Text(
                  'Total Payable: ${paymentPlan.orderPaymentplanTotals.totalPayableAmount}'),
              const SizedBox(height: 8),
              Text(paymentPlan.orderPaymentplanFuturePaymentsInfo),
            ],
            if (paymentPlan.productPaymentplanEnabled) ...[
              Text(
                'Product Payment Plan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(paymentPlan.productPaymentplanFuturePaymentsInfo),
            ],
          ],
        ),
      ),
    );
  }
}
