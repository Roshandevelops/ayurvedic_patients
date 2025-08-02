import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:ayurvedic_patients/infrastructure/branch_controller.dart';
import 'package:ayurvedic_patients/infrastructure/treatement_controller.dart';
import 'package:ayurvedic_patients/presentation/register/widget/add_treatment_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/date_picker_field_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/location_branch_dropdown_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/payment_radio_button_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/saved_treatments.dart';
import 'package:ayurvedic_patients/presentation/register/widget/treatement_time_widget.dart';
import 'package:ayurvedic_patients/presentation/widget/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:ayurvedic_patients/presentation/widget/app_textformfield.dart';
import 'package:provider/provider.dart';

class RegisterPatientsScreen extends StatefulWidget {
  const RegisterPatientsScreen({super.key});

  @override
  State<RegisterPatientsScreen> createState() => _RegisterPatientsScreenState();
}

class _RegisterPatientsScreenState extends State<RegisterPatientsScreen> {
  late BranchController branchController;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchBranchesAndTreatments();
    });
    super.initState();
  }

  Map<String, dynamic> data = {};

  void fetchBranchesAndTreatments() async {
    await Provider.of<TreatementController>(context, listen: false)
        .getAllTreatements();
    await Provider.of<BranchController>(context, listen: false).getBranch();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();
  TextEditingController advanceAmountController = TextEditingController();
  TextEditingController balanceAmountController = TextEditingController();
  TextEditingController treatmentDateController = TextEditingController();
  final List<TreatmentModel> savedTreatments = [];
  String? selectedBranchID;
  String? selectedLocation;
  String? selectedTreatmentModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<BranchController>(builder: (context, branchValue, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white),
        body: SingleChildScrollView(
          /// Heading
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
                      controller: nameController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Name',
                      hint: 'Enter your full name',
                    ),
                    const SizedBox(height: 25),
                    AppTextFormField(
                      controller: numberController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Whatsapp Number',
                      hint: 'Enter your Whatsapp number',
                    ),
                    const SizedBox(height: 25),
                    AppTextFormField(
                      controller: addressController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Address',
                      hint: 'Enter your full address',
                    ),
                    const SizedBox(height: 25),

                    ///  Dropdown for Location and Branch
                    LocationBranchDropdownWidget(
                      selectedBranch: selectedBranchID,
                      onChangedBranch: (valueBranch) {
                        selectedBranchID = valueBranch;
                      },
                      selectedLocation: selectedLocation,
                      onLocationChanged: (valueLocation) {
                        selectedLocation = valueLocation;
                      },
                    ),
                    const SizedBox(height: 25),

                    ///  Added Treatements List
                    if (savedTreatments.isNotEmpty) ...[
                      SavedTreatments(
                        savedTreatments: savedTreatments,
                      ),
                    ],

                    ///  Bottom Sheet
                    SizedBox(
                      width: double.infinity,
                      child: AppElevatedButton(
                        onPressed: () {
                          Provider.of<TreatementController>(context,
                                  listen: false)
                              .resetGenderCount();
                          openBottomSheet();
                        },
                        iconData: Icons.add,
                        buttonText: "Add Treatments",
                        textStyle: TextStyle(color: Colors.black),
                        backgroundColor: Colors.green.shade100,
                      ),
                    ),
                    const SizedBox(height: 25),

                    ///  Text Fields
                    AppTextFormField(
                      controller: totalAmountController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Total Amount',
                    ),
                    const SizedBox(height: 25),
                    AppTextFormField(
                      controller: discountAmountController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Discount Amount',
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    /// Payment Radio button
                    const PaymentRadioButtonWidget(),

                    const SizedBox(
                      height: 25,
                    ),

                    ///  Texr Fields
                    AppTextFormField(
                      controller: advanceAmountController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: "Advance Amount",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AppTextFormField(
                      controller: balanceAmountController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: "Balance Amount",
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    ///  Date picker TextField
                    const DatePickerFieldWidget(),

                    const SizedBox(
                      height: 25,
                    ),

                    ///  Treatement Time
                    const TreatementTimeWidget(),

                    const SizedBox(
                      height: 40,
                    ),

                    /// All Details Save Button
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: AppElevatedButton(
                        onPressed: () {
                          List<String?> selectedTreatmentIDS =
                              savedTreatments.map((e) => e.idAsString).toList();
                          String treatmentIDs = selectedTreatmentIDS
                              .whereType<String>()
                              .join(',');

                          print("testing $treatmentIDs");
                          data.addAll({
                            "name": "Roshan Ochu",
                            "excecutive": "Dr. Arya",
                            "payment": "Cash",
                            "phone": "9876543210",
                            "address": "Wayanad, Kerala",
                            "total_amount": 1500,
                            "discount_amount": 200,
                            "advance_amount": 500,
                            "balance_amount": 800,
                            "date_nd_time": "01/08/2025-10:24 AM",
                            "id": "",
                            "male": "2,3",
                            "female": "4",
                            "branch": selectedBranchID,
                            "treatments": treatmentIDs
                          });

                          if (nameController.text.isEmpty) {
                            return;
                          } else if (numberController.text.isEmpty) {
                            return;
                          } else if (addressController.text.isEmpty) {
                            return;
                          } else if (selectedBranchID == null) {
                            return;
                          } else if (selectedLocation == null) {
                            return;
                          } else if (totalAmountController.text.isEmpty) {
                            return;
                          } else if (discountAmountController.text.isEmpty) {
                            return;
                          } else if (addressController.text.isEmpty) {
                            return;
                          } else if (balanceAmountController.text.isEmpty) {
                            return;
                          } else if (treatmentDateController.text.isEmpty) {
                            return;
                          }
                        },
                        buttonText: "Save",
                        textStyle: const TextStyle(color: Colors.white),
                        backgroundColor: const Color(0xff006837),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void openBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AddTreatmentBottomSheet(
          onSave: (treatmentModel) {
            setState(() {
              savedTreatments.add(treatmentModel);
            });
          },
        );
      },
    );
  }
}
