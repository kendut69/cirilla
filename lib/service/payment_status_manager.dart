import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/payment_schedule.dart';
import 'package:dio/dio.dart';

enum PaymentStatus { pending, processing, completed, failed, overdue }

class PaymentStatusManager extends ChangeNotifier {
  final Map<int, PaymentStatus> _statusMap = {};
  final Map<int, DateTime> _lastUpdateMap = {};
  final Dio dio = Dio();

  // Status stream controller untuk real-time updates
  final _statusController =
      StreamController<Map<int, PaymentStatus>>.broadcast();
  Stream<Map<int, PaymentStatus>> get statusStream => _statusController.stream;

  Future<void> updatePaymentStatus(
      int installmentNumber, PaymentStatus newStatus) async {
    try {
      // Update status locally
      _statusMap[installmentNumber] = newStatus;
      _lastUpdateMap[installmentNumber] = DateTime.now().toUtc();

      // Notify listeners
      notifyListeners();
      _statusController.add(_statusMap);

      // Sync with server
      await _syncStatusWithServer(installmentNumber, newStatus);
    } catch (e) {
      debugPrint('Error updating payment status: $e');
      // Revert status if server sync fails
      _statusMap[installmentNumber] = PaymentStatus.pending;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> _syncStatusWithServer(
      int installmentNumber, PaymentStatus status) async {
    try {
      final response = await dio.post(
        '/wp-json/wc/v3/payment-schedule/update-status',
        data: {
          'installment_number': installmentNumber,
          'status': status.toString().split('.').last,
          'timestamp': _lastUpdateMap[installmentNumber]?.toIso8601String(),
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to sync status with server');
      }
    } catch (e) {
      debugPrint('Error syncing status: $e');
      rethrow;
    }
  }

  // Check for overdue payments
  void checkOverduePayments(List<PaymentSchedule> schedules) {
    final now = DateTime.now().toUtc();

    for (var schedule in schedules) {
      if (schedule.dueDate.isBefore(now) &&
          _statusMap[schedule.installmentNumber] == PaymentStatus.pending) {
        updatePaymentStatus(schedule.installmentNumber, PaymentStatus.overdue);
      }
    }
  }

  // Get payment status with color
  Color getStatusColor(PaymentStatus status, BuildContext context) {
    final theme = Theme.of(context);

    switch (status) {
      case PaymentStatus.pending:
        return theme.colorScheme.primary;
      case PaymentStatus.processing:
        return Colors.orange;
      case PaymentStatus.completed:
        return Colors.green;
      case PaymentStatus.failed:
        return Colors.red;
      case PaymentStatus.overdue:
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
  }

  // Get readable status text
  String getStatusText(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.completed:
        return 'Completed';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.overdue:
        return 'Overdue';
      default:
        return 'Unknown';
    }
  }

  @override
  void dispose() {
    _statusController.close();
    super.dispose();
  }
}
