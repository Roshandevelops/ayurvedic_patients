import 'package:ayurvedic_patients/presentation/register/widget/dropdown_field_widget.dart';
import 'package:flutter/material.dart';

class TreatementTimeWidget extends StatefulWidget {
  const TreatementTimeWidget({
    super.key,
    required this.onHourChanged,
    required this.onMinuteChanged,
    required this.selectedHour,
    required this.selectedMinute,
  });

  final void Function(String?) onHourChanged;
  final void Function(String?) onMinuteChanged;

  final String? selectedHour;
  final String? selectedMinute;

  @override
  State<TreatementTimeWidget> createState() => _TreatementTimeWidgetState();
}

class _TreatementTimeWidgetState extends State<TreatementTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomDropdownFieldWidget(
            hintText: "Hour",
            items: [
              "00",
              "01",
              "02",
              "03",
              "04",
              "05",
              "06",
              "07",
              "08",
              "09",
              "10",
              "11",
              "12",
              "13",
              "14",
              "15",
              "16",
              "17",
              "18",
              "19",
              "20",
              "21",
              "22",
              "23",
              "24",
            ]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {
              widget.onHourChanged(value);
            },
            title: "Treatement Time",
            value: widget.selectedHour,
          ),
        ),
        Expanded(
          child: CustomDropdownFieldWidget(
            hintText: "Minute",
            items: [
              "00",
              "01",
              "02",
              "03",
              "04",
              "05",
              "06",
              "07",
              "08",
              "09",
              "10",
              "11",
              "12",
              "13",
              "14",
              "15",
              "16",
              "17",
              "18",
              "19",
              "20",
              "21",
              "22",
              "23",
              "24",
              "25",
              "26",
              "27",
              "28",
              "29",
              "30",
              "31",
              "32",
              "33",
              "34",
              "35",
              "36",
              "37",
              "38",
              "39",
              "40",
              "41",
              "42",
              "43",
              "44",
              "45",
              "46",
              "47",
              "48",
              "49",
              "50",
              "51",
              "52",
              "53",
              "54",
              "55",
              "56",
              "57",
              "58",
              "59",
              "60",
            ]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {
              widget.onMinuteChanged(value);
            },
            title: " ",
            value: widget.selectedMinute,
          ),
        ),
      ],
    );
  }
}
