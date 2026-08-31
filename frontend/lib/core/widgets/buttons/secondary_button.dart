import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.showArrow = false,
    this.color,
  });

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool showArrow;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color ?? AppColors.primary500,
        elevation: 2,
        shadowColor: Colors.black38,
        side: BorderSide(color: color ?? AppColors.primary500, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon), const SizedBox(width: 8)],

          Text(text),

          if (showArrow) ...[
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward),
          ],
        ],
      ),
    );
  }
}
