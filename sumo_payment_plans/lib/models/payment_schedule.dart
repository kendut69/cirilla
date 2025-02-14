class PaymentSchedule {
  final int installmentNumber;
  final DateTime dueDate;
  final double amount;
  final String status;

  PaymentSchedule({
    required this.installmentNumber,
    required this.dueDate,
    required this.amount,
    required this.status,
  });

  factory PaymentSchedule.fromJson(Map<String, dynamic> json) {
    return PaymentSchedule(
      installmentNumber: json['installment_number'],
      dueDate: DateTime.parse(json['due_date']),
      amount: json['amount'].toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'installment_number': installmentNumber,
      'due_date': dueDate.toIso8601String(),
      'amount': amount,
      'status': status,
    };
  }
}
