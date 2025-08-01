import 'package:ayurvedic_patients/infrastructure/branch_controller.dart';
import 'package:ayurvedic_patients/presentation/register/widget/dropdown_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationBranchDropdownWidget extends StatefulWidget {
  const LocationBranchDropdownWidget({super.key});

  @override
  State<LocationBranchDropdownWidget> createState() =>
      _LocationBranchDropdownWidgetState();
}

class _LocationBranchDropdownWidgetState
    extends State<LocationBranchDropdownWidget> {
  final List<String> demoLocations = ['Wayanad', 'Kozhikode', 'Kannur'];
  String? selectedLocation;
  String? selectedBranch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownFieldWidget(
          hintText: "Choose your location",
          title: 'Location',
          value: selectedLocation,
          items: demoLocations
              .map(
                (e) => MenuItem(id: e, name: e),
              )
              .toList(),
          onChanged: (value) => setState(() => selectedLocation = value),
        ),
        const SizedBox(height: 25),

        ///  Dropdown for Branch
        Consumer<BranchController>(builder: (context, branchValue, child) {
          return CustomDropdownFieldWidget(
            hintText: "Select the branch",
            title: 'Branch',
            value: selectedBranch,
            items: branchValue.branchList
                .map(
                  (e) => MenuItem(
                    id: e.id.toString(),
                    name: e.name.toString(),
                  ),
                )
                .toList(),
            onChanged: (val) {
              setState(
                () {
                  selectedBranch = val;
                  print(selectedBranch);
                },
              );
            },
          );
        }),
      ],
    );
  }
}
