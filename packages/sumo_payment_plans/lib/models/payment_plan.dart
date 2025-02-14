import 'payment_schedule.dart';

class PaymentPlan {
  final bool orderPaymentplanEnabled;
  final bool productPaymentplanEnabled;
  final PaymentPlanTotals orderPaymentplanTotals;
  final String orderPaymentplanFuturePaymentsInfo;
  final String productPaymentplanFuturePaymentsInfo;
  final List<PaymentSchedule> paymentSchedule;

  PaymentPlan({
    required this.orderPaymentplanEnabled,
    required this.productPaymentplanEnabled,
    required this.orderPaymentplanTotals,
    required this.orderPaymentplanFuturePaymentsInfo,
    required this.productPaymentplanFuturePaymentsInfo,
    required this.paymentSchedule,
  });

  factory PaymentPlan.fromJson(Map<String, dynamic> json) {
    return PaymentPlan(
      orderPaymentplanEnabled: json['order_paymentplan_enabled'],
      productPaymentplanEnabled: json['product_paymentplan_enabled'],
      orderPaymentplanTotals:
          PaymentPlanTotals.fromJson(json['order_paymentplan_totals']),
      orderPaymentplanFuturePaymentsInfo:
          json['order_paymentplan_future_payments_info'],
      productPaymentplanFuturePaymentsInfo:
          json['product_paymentplan_future_payments_info'],
      paymentSchedule: (json['payment_schedule'] as List)
          .map((item) => PaymentSchedule.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_paymentplan_enabled': orderPaymentplanEnabled,
      'product_paymentplan_enabled': productPaymentplanEnabled,
      'order_paymentplan_totals': orderPaymentplanTotals.toJson(),
      'order_paymentplan_future_payments_info':
          orderPaymentplanFuturePaymentsInfo,
      'product_paymentplan_future_payments_info':
          productPaymentplanFuturePaymentsInfo,
      'payment_schedule': paymentSchedule.map((item) => item.toJson()).toList(),
    };
  }
}

class PaymentPlanTotals {
  final String downPayment;
  final String totalPayableAmount;

  PaymentPlanTotals({
    required this.downPayment,
    required this.totalPayableAmount,
  });

  factory PaymentPlanTotals.fromJson(Map<String, dynamic> json) {
    return PaymentPlanTotals(
      downPayment: json['down_payment'],
      totalPayableAmount: json['total_payable_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'down_payment': downPayment,
      'total_payable_amount': totalPayableAmount,
    };
  }
}
