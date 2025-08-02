import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.textStyle,
    required this.backgroundColor,
    this.iconData,
  });
  final void Function()? onPressed;

  final String buttonText;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData != null) ...[
            Icon(iconData, size: 18, color: textStyle?.color),
            const SizedBox(width: 6),
          ],
          Text(buttonText, style: textStyle),
        ],
      ),
    );
  }
}
