import 'package:flutter/material.dart';

class RequestPriorityBadge extends StatelessWidget {
  const RequestPriorityBadge({super.key, required this.priority});

  final String priority;

  Color get _backgroundColor => switch (priority) {
    'کم' => const Color(0xFFE4F3E8),
    'متوسط' => const Color(0xFFFFF3D6),
    'زیاد' => const Color(0xFFFCE8E6),
    _ => const Color(0xFFEEEEEE),
  };

  Color get _foregroundColor => switch (priority) {
    'کم' => const Color(0xFF347449),
    'متوسط' => const Color(0xFF946200),
    'زیاد' => const Color(0xFFB3261E),
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
        priority,
        style: TextStyle(
          color: _foregroundColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
