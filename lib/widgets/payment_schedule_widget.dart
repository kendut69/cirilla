import 'package:flutter/material.dart';
import '../models/payment_schedule.dart';
import 'package:intl/intl.dart';

class PaymentScheduleWidget extends StatelessWidget {
  final List<PaymentSchedule> schedules;
  final String currency;
  final double totalAmount;
  final double downPayment;

  const PaymentScheduleWidget({
    Key? key,
    required this.schedules,
    required this.currency,
    required this.totalAmount,
    required this.downPayment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(symbol: currency);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Schedule',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${schedules.length} Installments',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Down Payment Row
          ListTile(
            title: const Text('Down Payment'),
            trailing: Text(
              currencyFormat.format(downPayment),
              style: theme.textTheme.titleMedium,
            ),
            tileColor: theme.colorScheme.surface,
          ),
          // Payment Schedule List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final schedule = schedules[index];
              return Column(
                children: [
                  ListTile(
                    title: Text('Installment ${schedule.installmentNumber}'),
                    subtitle: Text(
                      'Due Date: ${DateFormat('yyyy-MM-dd').format(schedule.dueDate)}',
                      style: TextStyle(
                        color: _getDueDateColor(schedule.dueDate, theme),
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          currencyFormat.format(schedule.amount),
                          style: theme.textTheme.titleMedium,
                        ),
                        _buildStatusChip(schedule.status, theme),
                      ],
                    ),
                  ),
                  if (index < schedules.length - 1) const Divider(height: 1),
                ],
              );
            },
          ),
          const Divider(height: 1),
          // Total Amount Row
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currencyFormat.format(totalAmount),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status, ThemeData theme) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.orange.withOpacity(0.2);
        textColor = Colors.orange.shade800;
        break;
      case 'completed':
        backgroundColor = Colors.green.withOpacity(0.2);
        textColor = Colors.green.shade800;
        break;
      case 'failed':
        backgroundColor = Colors.red.withOpacity(0.2);
        textColor = Colors.red.shade800;
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.2);
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getDueDateColor(DateTime dueDate, ThemeData theme) {
    final now = DateTime.now();
    if (dueDate.isBefore(now)) {
      return Colors.red;
    }
    if (dueDate.difference(now).inDays <= 7) {
      return Colors.orange;
    }
    return theme.textTheme.bodyMedium?.color ?? Colors.black;
  }
}
