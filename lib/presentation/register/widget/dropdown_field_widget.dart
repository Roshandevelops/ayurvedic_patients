import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdownFieldWidget extends StatefulWidget {
  final String? title;
  final List<MenuItem> items;
  final MenuItem? value;
  final ValueChanged<MenuItem?> onChanged;
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
  State<CustomDropdownFieldWidget> createState() =>
      _CustomDropdownFieldWidgetState();
}

class _CustomDropdownFieldWidgetState extends State<CustomDropdownFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title ?? "",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<MenuItem>(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xff006837),
          ),
          value: widget.value,
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
            widget.hintText,
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          items: widget.items
              .map((item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: Text(item.name ?? "Unknown"),
                  ))
              .toList(),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}

class MenuItem {
  final String id;
  final String? name;

  MenuItem({
    required this.id,
    required this.name,
  });
}
