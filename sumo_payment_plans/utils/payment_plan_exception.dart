class PaymentPlanException implements Exception {
  final String message;
  final String? code;

  PaymentPlanException({required this.message, this.code});

  @override
  String toString() {
    if (code != null) {
      return 'PaymentPlanException: $message (Code: $code)';
    }
    return 'PaymentPlanException: $message';
  }
}
