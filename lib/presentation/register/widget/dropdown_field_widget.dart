import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String hintText;

  const CustomDropdownField({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hintText,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: widget.value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
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
            widget.hintText,
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          items: widget.items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
