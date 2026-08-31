import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.primary500,
        foregroundColor: AppColors.white50,
        elevation: 6,
        shadowColor: Colors.black38,
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
