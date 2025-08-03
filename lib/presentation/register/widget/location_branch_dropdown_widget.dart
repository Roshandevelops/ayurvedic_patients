import 'package:ayurvedic_patients/domain/model/branch_model.dart';
import 'package:ayurvedic_patients/infrastructure/branch_controller.dart';
import 'package:ayurvedic_patients/presentation/register/widget/dropdown_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationBranchDropdownWidget extends StatefulWidget {
  const LocationBranchDropdownWidget({
    super.key,
    required this.selectedLocation,
    required this.onLocationChanged,
    required this.selectedBranch,
    required this.onChangedBranch,
    
  });

  final  BranchModel? selectedBranch;
  final String? selectedLocation;
  final ValueChanged<String?> onLocationChanged;
  final void Function(BranchModel?) onChangedBranch;

  @override
  State<LocationBranchDropdownWidget> createState() =>
      _LocationBranchDropdownWidgetState();
}

class _LocationBranchDropdownWidgetState
    extends State<LocationBranchDropdownWidget> {
  final List<String> staticLocations = ['Wayanad', 'Kozhikode', 'Kannur'];

 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown for Locatoon
        CustomDropdownFieldWidget(
            hintText: "Choose your location",
            title: 'Location',
            value: widget.selectedLocation,
            items: staticLocations
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                widget.onLocationChanged(value);
              });
            }),
        const SizedBox(height: 25),

        ///  Dropdown for Branch
        Consumer<BranchController>(
          builder: (context, branchValue, child) {
            return CustomDropdownFieldWidget<BranchModel>(
              hintText: "Select the branch",
              title: 'Branch',
              value:widget. selectedBranch,
              items: branchValue.branchList
                  .map(
                    (e) => DropdownMenuItem<BranchModel>(
                      value: e,
                      child: Text(e.name ?? ""),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(
                  () {
                    widget.onChangedBranch(value);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
