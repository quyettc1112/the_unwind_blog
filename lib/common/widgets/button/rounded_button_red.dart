import 'package:flutter/material.dart';
import 'package:the_unwind_blog/common/helper/is_dark_mode.dart';
import 'package:the_unwind_blog/core/config/theme/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.isDarkMode ? Colors.white : Colors.blue, // Nền trắng
        foregroundColor: Colors.black, // Chữ đen
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
      ),
      child: Text(
        text,
        style: const TextStyle(// Chữ đen
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
