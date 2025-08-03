import 'package:ayurvedic_patients/domain/model/branch_model.dart';
import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:ayurvedic_patients/infrastructure/branch_controller.dart';
import 'package:ayurvedic_patients/infrastructure/patient_controller.dart';
import 'package:ayurvedic_patients/infrastructure/treatement_controller.dart';
import 'package:ayurvedic_patients/infrastructure/update_patient_controller.dart';
import 'package:ayurvedic_patients/presentation/register/widget/add_treatment_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/date_picker_field_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/generate_patient_pdf.dart';
import 'package:ayurvedic_patients/presentation/register/widget/location_branch_dropdown_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/payment_radio_button_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/saved_treatments.dart';
import 'package:ayurvedic_patients/presentation/register/widget/treatement_time_widget.dart';
import 'package:ayurvedic_patients/presentation/widget/app_elevated_button.dart';
import 'package:ayurvedic_patients/utils/k_color_constants.dart';
import 'package:ayurvedic_patients/utils/k_size_constants.dart';
import 'package:flutter/material.dart';
import 'package:ayurvedic_patients/presentation/widget/app_textformfield.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterPatientsScreen extends StatefulWidget {
  const RegisterPatientsScreen({
    super.key,
  });

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

  Map<String, String> data = {};

  void fetchBranchesAndTreatments() async {
    await Provider.of<TreatementController>(context, listen: false)
        .getAllTreatements();

    if (mounted) {
      await Provider.of<BranchController>(context, listen: false).getBranch();
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController discountAmountController =
      TextEditingController();
  final TextEditingController advanceAmountController = TextEditingController();
  final TextEditingController balanceAmountController = TextEditingController();
  final TextEditingController treatmentDateController = TextEditingController();
  final List<TreatmentModel> savedTreatments = [];

  BranchModel? selectedBranch;
  String? selectedLocation;
  String? selectedHour;
  String? selectedMinute;

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
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(12),
                      ],
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
                      selectedBranch: selectedBranch,
                      onChangedBranch: (valueBranch) {
                        selectedBranch = valueBranch;
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
                        textStyle: const TextStyle(color: Colors.black),
                        backgroundColor: Colors.green.shade100,
                      ),
                    ),
                    const SizedBox(height: 25),

                    ///  Text Fields
                    AppTextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: totalAmountController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Total Amount',
                    ),
                    const SizedBox(height: 25),
                    AppTextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: advanceAmountController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: "Advance Amount",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AppTextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: balanceAmountController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: "Balance Amount",
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    ///  Date picker TextField
                    DatePickerFieldWidget(
                      treatmentDateController: treatmentDateController,
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    ///  Treatement Time
                    TreatementTimeWidget(
                        selectedHour: selectedHour,
                        selectedMinute: selectedMinute,
                        onHourChanged: (value) {
                          setState(() {
                            selectedHour = value;
                          });
                        },
                        onMinuteChanged: (value) => setState(() {
                              selectedMinute = value;
                            })),

                    const SizedBox(
                      height: 40,
                    ),

                    /// All Details Save Button
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: AppElevatedButton(
                        onPressed: () async {
                          List<TreatmentModel?> selectedTreatments =
                              savedTreatments.map((e) => e).toList();
                          List<String> selectedTreatmentIDs = selectedTreatments
                              .map((e) => (e?.idAsString.toString() ?? ""))
                              .toList();

                          String treatmentIDs = selectedTreatmentIDs
                              .whereType<String>()
                              .join(',');

                          selectedTreatments
                              .map((e) => (e?.name.toString() ?? ""))
                              .toList();

                          data.addAll(
                            {
                              "name": nameController.text,
                              "excecutive": "Dr. Arya",
                              "payment": "Cash",
                              "phone": numberController.text,
                              "address": addressController.text,
                              "total_amount": totalAmountController.text,
                              "discount_amount": discountAmountController.text,
                              "advance_amount": advanceAmountController.text,
                              "balance_amount": balanceAmountController.text,
                              "date_nd_time": treatmentDateController.text,
                              "id": "",
                              "male": treatmentIDs,
                              "female": treatmentIDs,
                              "branch": selectedBranch?.id.toString() ?? "",
                              "treatments": treatmentIDs,
                            },
                          );

                          if (treatmentIDs.isEmpty ||
                              nameController.text.isEmpty ||
                              numberController.text.isEmpty ||
                              addressController.text.isEmpty ||
                              selectedBranch?.id == null ||
                              selectedLocation == null ||
                              totalAmountController.text.isEmpty ||
                              discountAmountController.text.isEmpty ||
                              balanceAmountController.text.isEmpty ||
                              treatmentDateController.text.isEmpty ||
                              selectedHour == null ||
                              selectedMinute == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please fill all required fields'),
                              ),
                            );
                            return;
                          } else {
                            await Provider.of<UpdatePatientController>(context,
                                    listen: false)
                                .submitPatientData(
                              data: data,
                            );
                            await GeneratePatientPDF(
                              nameController: nameController,
                              numberController: numberController,
                              addressController: addressController,
                              totalAmountController: totalAmountController,
                              discountAmountController:
                                  discountAmountController,
                              advanceAmountController: advanceAmountController,
                              balanceAmountController: balanceAmountController,
                              treatmentDateController: treatmentDateController,
                              savedTreatments: savedTreatments,
                              selectedBranch: selectedBranch,
                              selectedLocation: selectedLocation,
                              selectedHour: selectedHour,
                              selectedMinute: selectedMinute,
                            ).generatePDF(data);
                            if (context.mounted) {
                              Provider.of<PatientController>(context,
                                      listen: false)
                                  .fetchPatients();
                            }
                          }
                        },
                        buttonText: "Save",
                        textStyle:
                            const TextStyle(color: KColorConstants.kWhiteColor),
                        backgroundColor:
                            KColorConstants.elevatedButtonGreenColor,
                      ),
                    ),
                    KSizeConstants.kHeight20,
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
