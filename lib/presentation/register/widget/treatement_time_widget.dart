import 'package:ayurvedic_patients/presentation/register/widget/dropdown_field_widget.dart';
import 'package:flutter/material.dart';

class TreatementTimeWidget extends StatefulWidget {
  const TreatementTimeWidget({super.key});

  @override
  State<TreatementTimeWidget> createState() => _TreatementTimeWidgetState();
}

class _TreatementTimeWidgetState extends State<TreatementTimeWidget> {

   String? selectedTreatmentModel;
  @override
  Widget build(BuildContext context) {
    return Row(
                      children: [
                        Expanded(
                          child: CustomDropdownFieldWidget(
                              hintText: "Hour",
                              items: [],
                              onChanged: (value) {
                                setState(() {
                                  selectedTreatmentModel = value;
                                });
                              },
                              title: "Treatement Time",
                              value: selectedTreatmentModel),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomDropdownFieldWidget(
                            hintText: "Minutes",
                            items: [],
                            onChanged: (value) {
                              setState(() {
                                selectedTreatmentModel = value;
                              });
                            },
                            value: selectedTreatmentModel,
                          ),
                        ),
                      ],
                    );
  }
}