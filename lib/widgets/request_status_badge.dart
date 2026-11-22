import 'package:flutter/material.dart';

class RequestStatusBadge extends StatelessWidget {
  const RequestStatusBadge({super.key, required this.status});

  final String status;

  Color get _backgroundColor => switch (status) {
    'ثبت شده' => const Color(0xFFE8F1F4),
    'در حال پیگیری' => const Color(0xFFFFF3D6),
    'انجام شده' => const Color(0xFFE4F3E8),
    _ => const Color(0xFFEEEEEE),
  };

  Color get _foregroundColor => switch (status) {
    'ثبت شده' => const Color(0xFF376C7D),
    'در حال پیگیری' => const Color(0xFF946200),
    'انجام شده' => const Color(0xFF347449),
    _ => const Color(0xFF555555),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: _foregroundColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
