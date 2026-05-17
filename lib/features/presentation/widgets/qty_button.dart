import 'package:flutter/material.dart';

class QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFEEECFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF6C63FF)),
      ),
    );
  }
}

