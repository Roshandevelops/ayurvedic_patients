import 'dart:developer';
import 'package:ayurvedic_patients/infrastructure/branch_controller.dart';
import 'package:ayurvedic_patients/presentation/register/widget/dropdown_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:ayurvedic_patients/presentation/widget/app_textformfield.dart';
import 'package:provider/provider.dart';

class RegisterPatients extends StatefulWidget {
  const RegisterPatients({super.key});

  @override
  State<RegisterPatients> createState() => _RegisterPatientsState();
}

class _RegisterPatientsState extends State<RegisterPatients> {
  late BranchController branchController;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchBracnhes();
    });

    super.initState();
  }

  void fetchBracnhes() async {
    await Provider.of<BranchController>(context, listen: false).getBranch();
  }

  final List<String> demoLocations = ['Wayanad', 'Kozhikode', 'Kannur'];

  String? selectedLocation;
  String? selectedBranch;

  int? selectedBranchId;
  @override
  Widget build(BuildContext context) {
    return Consumer<BranchController>(builder: (context, branchValue, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Color(0xff404040),
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    /// Textfields
                    AppTextFormField(
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Name',
                      hint: 'Enter your full name',
                    ),
                    const SizedBox(height: 25),
                    AppTextFormField(
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Whatsapp Number',
                      hint: 'Enter your Whatsapp number',
                    ),
                    const SizedBox(height: 25),
                    AppTextFormField(
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Address',
                      hint: 'Enter your full address',
                    ),
                    const SizedBox(height: 25),

                    ///  Dropdown for Location
                    CustomDropdownField(
                      hintText: "Choose your location",
                      title: 'Location',
                      value: selectedLocation,
                      items: demoLocations,
                      onChanged: (value) =>
                          setState(() => selectedLocation = value),
                    ),
                    const SizedBox(height: 25),

                    ///  Dropdown for Branch
                    CustomDropdownField(
                      hintText: "Select the branch",
                      title: 'Branch',
                      value: selectedBranch,
                      items: branchValue.branchList
                          .map((e) => e.name.toString())
                          .toList(),
                      onChanged: (val) {
                        final selectedBranchModel = branchValue.branchList
                            .firstWhere((element) => element.name == val);

                        setState(
                          () {
                            selectedBranch = val;
                            selectedBranchId = selectedBranchModel.id;
                          },
                        );

                        log("Selected Branch ID: $selectedBranchId");
                      },
                    ),
                    const SizedBox(height: 25),

                    /// Add Treatement
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text("Add Treatments"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.green.shade100,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
