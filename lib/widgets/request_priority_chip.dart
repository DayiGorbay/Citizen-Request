import 'package:flutter/material.dart';

class RequestPriorityChip extends StatelessWidget {
  const RequestPriorityChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  Color get _color => switch (label) {
    'کم' => const Color(0xFF5B91A3),
    'متوسط' => const Color(0xFFB77900),
    'زیاد' => const Color(0xFFB3261E),
    _ => const Color(0xFF5B91A3),
  };

  Color _surface(bool isDark) => switch (label) {
    'کم' => isDark ? const Color(0xFF20383F) : const Color(0xFFE8F1F4),
    'متوسط' => isDark ? const Color(0xFF493812) : const Color(0xFFFFF3D6),
    'زیاد' => isDark ? const Color(0xFF4A2422) : const Color(0xFFFCE8E6),
    _ => isDark ? const Color(0xFF20383F) : const Color(0xFFE8F1F4),
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isSelected ? _color : _surface(isDark),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : _color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
