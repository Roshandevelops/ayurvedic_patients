import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:ayurvedic_patients/infrastructure/branch_controller.dart';
import 'package:ayurvedic_patients/infrastructure/treatement_controller.dart';
import 'package:ayurvedic_patients/presentation/register/widget/date_picker_field_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/dropdown_field_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/gender_box.dart';
import 'package:ayurvedic_patients/presentation/register/widget/location_branch_dropdown_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/payment_radio_button_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/saved_treatments.dart';
import 'package:ayurvedic_patients/presentation/register/widget/treatement_time_widget.dart';
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
      fetchBranches();
    });

    super.initState();
  }

  Map<String, dynamic> data = {};

  void fetchBranches() async {
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
  String? selectedBranch;
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
                    const LocationBranchDropdownWidget(),

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
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Provider.of<TreatementController>(context,
                                  listen: false)
                              .resetGenderCount();

                          openBottomSheet();
                        },
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: const Color(0xff006837),
                        ),
                        onPressed: () {
                          List<String?> selectedTreatmentIDS =
                              savedTreatments.map((e) => e.idAsString).toList();

                          String treatmentIDs = selectedTreatmentIDS
                              .whereType<String>()
                              .join(',');

                          print("tttt $treatmentIDs");
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
                            "branch": selectedBranch,
                            "treatments": treatmentIDs
                          });
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
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
                    Consumer<TreatementController>(
                        builder: (context, treatementValue, child) {
                      return CustomDropdownFieldWidget(
                        hintText: "Choose preferred treatement",
                        items: treatementValue.treatmentList
                            .map(
                              (e) => MenuItem(
                                id: e.id.toString(),
                                name: e.name.toString(),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedTreatmentModel = value;
                          });
                        },
                        title: "Choose Treatement",
                        value: selectedTreatmentModel,
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Add patients"),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const GenderBox(
                              gender: "Male",
                            ),

                            const Spacer(),

                            /// Minus button
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0xff006837),
                              child: IconButton(
                                icon: const Icon(Icons.remove,
                                    color: Colors.white),
                                onPressed: () {
                                  Provider.of<TreatementController>(context,
                                          listen: false)
                                      .updateMaleCount(false);
                                  // Decrease count logic
                                },
                              ),
                            ),
                            const SizedBox(width: 6),

                            /// Small counter field
                            Container(
                              width: 48,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      const Color(0xff000000).withOpacity(0.30),
                                ),
                              ),
                              child: Consumer<TreatementController>(
                                  builder: (context, value, child) {
                                return Text(value.maleCount.toString());
                              }),
                            ),
                            const SizedBox(width: 6),

                            // Plus button
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0xff006837),
                              child: IconButton(
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  Provider.of<TreatementController>(context,
                                          listen: false)
                                      .updateMaleCount(true);

                                  /// Increase count logic
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const GenderBox(
                              gender: "Female",
                            ),

                            const Spacer(),

                            // Minus button
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0xff006837),
                              child: IconButton(
                                icon: const Icon(Icons.remove,
                                    color: Colors.white),
                                onPressed: () {
                                  Provider.of<TreatementController>(context,
                                          listen: false)
                                      .updateFemaleCount(false);
                                  // Decrease count logic
                                },
                              ),
                            ),
                            const SizedBox(width: 6),

                            /// Small counter field
                            Container(
                              alignment: Alignment.center,
                              width: 48,
                              height: 44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      const Color(0xff000000).withOpacity(0.30),
                                ),
                              ),
                              child: Consumer<TreatementController>(
                                  builder: (context, value, child) {
                                return Text(value.femaleCount.toString());
                              }),
                            ),
                            const SizedBox(width: 6),

                            ///  Plus button
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0xff006837),
                              child: IconButton(
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  ///  Increase count logic
                                  Provider.of<TreatementController>(context,
                                          listen: false)
                                      .updateFemaleCount(true);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: const Color(0xff006837),
                            ),
                            onPressed: () {
                              final treatmentController =
                                  Provider.of<TreatementController>(context,
                                      listen: false);

                              if (selectedTreatmentModel == null) return;

                              /// treatment name by id
                              final treatment = treatmentController
                                  .treatmentList
                                  .firstWhere((e) =>
                                      e.id.toString() ==
                                      selectedTreatmentModel);

                              setState(
                                () {
                                  print(treatment.id);
                                  savedTreatments.add(
                                    TreatmentModel(
                                      idAsString: treatment.id.toString(),
                                      name: treatment.name,
                                      male: treatmentController.maleCount,
                                      female: treatmentController.femaleCount,
                                    ),
                                  );
                                  treatmentController.resetGenderCount();
                                  selectedTreatmentModel = null;
                                },
                              );
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
