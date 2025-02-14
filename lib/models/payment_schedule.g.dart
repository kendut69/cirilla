// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentSchedule _$PaymentScheduleFromJson(Map<String, dynamic> json) =>
    PaymentSchedule(
      dueDate: DateTime.parse(json['dueDate'] as String),
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      installmentNumber: (json['installmentNumber'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentScheduleToJson(PaymentSchedule instance) =>
    <String, dynamic>{
      'dueDate': instance.dueDate.toIso8601String(),
      'amount': instance.amount,
      'status': instance.status,
      'installmentNumber': instance.installmentNumber,
    };
