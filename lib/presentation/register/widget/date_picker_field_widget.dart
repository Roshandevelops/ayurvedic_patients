import 'package:ayurvedic_patients/presentation/widget/app_textformfield.dart';
import 'package:flutter/material.dart';

class DatePickerFieldWidget extends StatefulWidget {
  const DatePickerFieldWidget(
      {super.key, required this.treatmentDateController});

  final TextEditingController treatmentDateController;

  @override
  State<DatePickerFieldWidget> createState() => _DatePickerFieldWidgetState();
}

class _DatePickerFieldWidgetState extends State<DatePickerFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            widget.treatmentDateController.text =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          });
        }
      },
      controller: widget.treatmentDateController,
      suffixIcon: const Icon(
        Icons.date_range,
        color: Color(0xff006837),
      ),
      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
      title: "Treatement Date",
    );
  }
}
