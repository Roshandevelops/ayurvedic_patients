import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    this.title,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
    this.contentPadding,
    this.fillColor,
    this.onTap,
    super.key,
  });

  final String? title;
  final String? hint;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(8.53),
      borderSide: BorderSide(
        color: const Color(0xFF000000).withOpacity(0.10),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5.98),
        ],
        TextFormField(
          onTap: onTap,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            fillColor: fillColor,
            //  const Color(0xFFD9D9D9).withOpacity(0.25),
            filled: true,
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF000000).withOpacity(0.40),
            ),
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            disabledBorder: border.copyWith(
              borderSide: BorderSide(
                width: 0.85,
                color: const Color(0xFF000000).withOpacity(0.10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
