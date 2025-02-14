import 'package:dio/dio.dart';
import 'dart:convert';

import '../models/payment_plan.dart';
import '../models/payment_schedule.dart';
import '../utils/payment_plan_exception.dart';

class SumoPaymentService {
  final String baseUrl;
  final String customerKey;
  final String customerSecret;
  late Dio dio;

  SumoPaymentService({
    required this.baseUrl,
    required this.customerKey,
    required this.customerSecret,
  }) {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode('$customerKey:$customerSecret')),
        'Content-Type': 'application/json',
      },
    ));
  }

  Future<PaymentPlan> getCartPaymentPlan() async {
    try {
      final response = await dio.get('/wp-json/wc/store/v1/cart');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['sumopaymentplans'];
        if (data is Map<String, dynamic>) {
          return PaymentPlan.fromJson(data);
        } else {
          throw PaymentPlanException(
            message: 'Invalid data format',
            code: 'INVALID_FORMAT',
          );
        }
      } else {
        throw PaymentPlanException(
          message: 'Failed to load payment plan',
          code: response.statusCode.toString(),
        );
      }
    } on DioError catch (e) {
      throw PaymentPlanException(
        message: 'Error getting payment plan: ${e.message}',
        code: e.response?.statusCode.toString(),
      );
    }
  }

  // Add more methods as needed for your specific use case
}
