import 'package:flutter/material.dart';

class CustomDropdownFieldWidget<T> extends StatelessWidget {
  final String? title;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hintText;

  const CustomDropdownFieldWidget({
    super.key,
    this.title,
    required this.items,
    this.value,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        DropdownButtonFormField<T>(
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xff006837),
          ),
          value: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
            ),
          ),
          hint: Text(
            hintText,
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
