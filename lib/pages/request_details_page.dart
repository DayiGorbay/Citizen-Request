import 'package:flutter/material.dart';

import '../models/citizen_request.dart';
import '../widgets/request_status_badge.dart';

class RequestDetailsPage extends StatelessWidget {
  const RequestDetailsPage({super.key, required this.request});

  final CitizenRequest request;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('جزئیات درخواست')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailRow(
                    icon: Icons.assignment_outlined,
                    label: 'عنوان',
                    value: request.title,
                    valueStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  _DetailRow(
                    icon: Icons.tag,
                    label: 'شناسه',
                    value: request.id,
                  ),
                  _DetailRow(
                    icon: Icons.category_outlined,
                    label: 'دسته‌بندی',
                    value: request.category,
                  ),
                  _DetailRow(
                    icon: Icons.track_changes_outlined,
                    label: 'وضعیت',
                    value: request.status,
                    valueWidget: RequestStatusBadge(status: request.status),
                  ),
                  _DetailRow(
                    icon: Icons.flag_outlined,
                    label: 'اولویت',
                    value: request.priority,
                  ),
                  _DetailRow(
                    icon: Icons.location_on_outlined,
                    label: 'نشانی',
                    value: request.address,
                  ),
                  _DetailRow(
                    icon: Icons.notes_outlined,
                    label: 'توضیحات',
                    value: request.description,
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
    this.valueWidget,
    this.valueStyle,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final String value;
  final Widget? valueWidget;
  final TextStyle? valueStyle;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(label, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 28),
            child: valueWidget ?? SelectableText(value, style: valueStyle),
          ),
          if (showDivider) const Divider(height: 20),
        ],
      ),
    );
  }
}
