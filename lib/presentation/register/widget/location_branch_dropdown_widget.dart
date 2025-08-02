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

  final String? selectedLocation;
  final ValueChanged<String?> onLocationChanged;

  final String? selectedBranch;
  final void Function(String?) onChangedBranch;

  @override
  State<LocationBranchDropdownWidget> createState() =>
      _LocationBranchDropdownWidgetState();
}

class _LocationBranchDropdownWidgetState
    extends State<LocationBranchDropdownWidget> {
  final List<String> staticLocations = ['Wayanad', 'Kozhikode', 'Kannur'];

  String? selectedBranchID;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownFieldWidget(
            hintText: "Choose your location",
            title: 'Location',
            value: widget.selectedLocation,
            items: staticLocations
                .map(
                  (e) => MenuItem(id: e, name: e),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                widget.onLocationChanged(value);
              });
            }),
        const SizedBox(height: 25),

        ///  Dropdown for Branch
        Consumer<BranchController>(builder: (context, branchValue, child) {
          return CustomDropdownFieldWidget(
            hintText: "Select the branch",
            title: 'Branch',
            value: selectedBranchID,
            items: branchValue.branchList
                .map(
                  (e) => MenuItem(
                    id: e.id.toString(),
                    name: e.name.toString(),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(
                () {
                  widget.onChangedBranch(value);
                  selectedBranchID = value;
                },
              );
            },
          );
        }),
      ],
    );
  }
}
