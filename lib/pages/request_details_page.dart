import 'package:flutter/material.dart';

import '../models/citizen_request.dart';
import '../widgets/request_status_badge.dart';
import '../widgets/request_priority_badge.dart';

class RequestDetailsPage extends StatelessWidget {
  const RequestDetailsPage({super.key, required this.request});

  final CitizenRequest request;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('جزئیات درخواست')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        const Icon(Icons.assignment_outlined, size: 30),
                        const SizedBox(width: 10,),
                        Text(
                          request.title,
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 28),
                  _DetailRow(
                    icon: Icons.tag,
                    label: 'شناسه',
                    value: request.id,
                    iconColor: primaryColor,
                  ),
                  _DetailRow(
                    icon: Icons.category_outlined,
                    label: 'دسته‌بندی',
                    value: request.category,
                    iconColor: primaryColor,
                  ),
                  _DetailRow(
                    icon: Icons.track_changes_outlined,
                    label: 'وضعیت',
                    value: request.status,
                    valueWidget: RequestStatusBadge(status: request.status),
                    iconColor: primaryColor,
                  ),
                  _DetailRow(
                    icon: Icons.flag_outlined,
                    label: 'اولویت',
                    value: request.priority,
                    valueWidget: RequestPriorityBadge(priority: request.priority),
                    iconColor: primaryColor,
                  ),
                  _DetailRow(
                    icon: Icons.location_on_outlined,
                    label: 'نشانی',
                    value: request.address,
                    iconColor: primaryColor,
                  ),
                  _DetailRow(
                    icon: Icons.notes_outlined,
                    label: 'توضیحات',
                    value: request.description,
                    iconColor: primaryColor,
                    showDivider: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    this.valueWidget,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final Widget? valueWidget;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(icon, size: 20, color: iconColor),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        label,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: valueWidget ?? SelectableText(value),
                ),
              ),
            ],
          ),
          if (showDivider) const Divider(height: 24),
        ],
      ),
    );
  }
}
