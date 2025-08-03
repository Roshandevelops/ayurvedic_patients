import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:ayurvedic_patients/infrastructure/treatement_controller.dart';
import 'package:ayurvedic_patients/presentation/register/widget/dropdown_field_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/gender_box.dart';
import 'package:ayurvedic_patients/presentation/widget/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTreatmentBottomSheet extends StatefulWidget {
  final void Function(TreatmentModel) onSave;

  const AddTreatmentBottomSheet({super.key, required this.onSave});

  @override
  State<AddTreatmentBottomSheet> createState() =>
      _AddTreatmentBottomSheetState();
}

class _AddTreatmentBottomSheetState extends State<AddTreatmentBottomSheet> {
  TreatmentModel? selectedTreatmentModel;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<TreatementController>(builder: (context, value, _) {
                  return CustomDropdownFieldWidget(
                    title: "Choose Treatement",
                    hintText: "Choose preferred treatement",
                    value: selectedTreatmentModel,
                    items: value.treatmentList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name ?? ""),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() => selectedTreatmentModel = val);
                    },
                  );
                }),
                const SizedBox(height: 20),
                const Text("Add patients"),
                const SizedBox(height: 10),

                /// Male counter
                genderCounter(
                  "Male",
                  true,
                ),
                const SizedBox(height: 30),

                /// Female counter
                genderCounter("Female", false),
                const SizedBox(height: 30),

                /// Save Button
                SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    onPressed: () {
                      final treatmentController =
                          Provider.of<TreatementController>(context,
                              listen: false);
                      if (selectedTreatmentModel == null) return;
                      final treatment = treatmentController.treatmentList
                          .firstWhere(
                              (e) => e.id.toString() == selectedTreatmentModel?.id.toString());

                      widget.onSave(
                        TreatmentModel(
                          idAsString: treatment.id.toString(),
                          name: treatment.name,
                          male: treatmentController.maleCount,
                          female: treatmentController.femaleCount,
                        ),
                      );
                      treatmentController.resetGenderCount();
                      Navigator.pop(context);
                    },
                    buttonText: "Save",
                    textStyle: const TextStyle(color: Colors.white),
                    backgroundColor: const Color(0xff006837),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget genderCounter(String gender, bool isMale) {
    return Row(
      children: [
        GenderBox(gender: gender),
        const Spacer(),
        circleButton(Icons.remove, () {
          final controller =
              Provider.of<TreatementController>(context, listen: false);
          isMale
              ? controller.updateMaleCount(false)
              : controller.updateFemaleCount(false);
        }),
        const SizedBox(width: 6),
        Container(
          width: 48,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          child: Consumer<TreatementController>(builder: (context, value, _) {
            return Text(isMale
                ? value.maleCount.toString()
                : value.femaleCount.toString());
          }),
        ),
        const SizedBox(width: 6),
        circleButton(Icons.add, () {
          final controller =
              Provider.of<TreatementController>(context, listen: false);
          isMale
              ? controller.updateMaleCount(true)
              : controller.updateFemaleCount(true);
        }),
      ],
    );
  }

  Widget circleButton(IconData icon, VoidCallback onPressed) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: const Color(0xff006837),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
