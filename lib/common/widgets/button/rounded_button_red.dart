import 'package:flutter/material.dart';
import 'package:the_unwind_blog/core/config/theme/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const RoundedButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.red_button, // Màu nền nút
        borderRadius: BorderRadius.circular(30), // Bo tròn góc
        border: Border(
          bottom: BorderSide(
            color: Colors.black, // Viền dưới màu đen
            width: 2, // Độ dày viền dưới
          ),
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Điều chỉnh khoảng cách bên trong nút
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white, // Màu chữ
            fontWeight: FontWeight.bold, // Chữ đậm
          ),
        ),
      ),
    );
  }
}
