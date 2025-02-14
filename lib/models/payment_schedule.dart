import 'package:json_annotation/json_annotation.dart';

part 'payment_schedule.g.dart';

@JsonSerializable()
class PaymentSchedule {
  final DateTime dueDate;
  final double amount;
  final String status;
  final int installmentNumber;

  PaymentSchedule({
    required this.dueDate,
    required this.amount,
    required this.status,
    required this.installmentNumber,
  });

  factory PaymentSchedule.fromJson(Map<String, dynamic> json) =>
      _$PaymentScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentScheduleToJson(this);

  String get formattedDueDate {
    return '${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}';
  }

  String get statusDisplay {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'completed':
        return 'Paid';
      case 'failed':
        return 'Failed';
      default:
        return 'Unknown';
    }
  }

  get isNotEmpty => null;
}
