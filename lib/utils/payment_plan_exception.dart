class PaymentPlanException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  PaymentPlanException({
    required this.message,
    this.code,
    this.data,
  });

  @override
  String toString() => 'PaymentPlanException: $message (Code: $code)';

  factory PaymentPlanException.fromResponse(Map<String, dynamic> response) {
    return PaymentPlanException(
      message: response['message'] ?? 'Unknown error occurred',
      code: response['code']?.toString(),
      data: response['data'],
    );
  }

  static String getErrorMessage(dynamic error) {
    if (error is PaymentPlanException) {
      return error.message;
    }
    if (error is Map<String, dynamic>) {
      return error['message'] ?? 'Unknown error occurred';
    }
    return 'An unexpected error occurred';
  }
}
