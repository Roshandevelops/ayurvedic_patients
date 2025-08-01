import 'dart:developer';
import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:ayurvedic_patients/infrastructure/branch_controller.dart';
import 'package:ayurvedic_patients/infrastructure/treatement_controller.dart';
import 'package:ayurvedic_patients/presentation/register/widget/dropdown_field_widget.dart';
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
      fetchBracnhes();
    });

    super.initState();
  }

  Map<String, dynamic> data = {};

  void fetchBracnhes() async {
    await Provider.of<TreatementController>(context, listen: false)
        .getAllTreatements();
    await Provider.of<BranchController>(context, listen: false).getBranch();
  }

  final List<String> demoLocations = ['Wayanad', 'Kozhikode', 'Kannur'];

  TextEditingController treatmentDateController = TextEditingController();

  final List<TreatmentModel> savedTreatments = [];

  String? selectedLocation;
  String? selectedBranch;
  String? selectedTreatement;
  String? selectedTreatmentModel;

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
                    CustomDropdownFieldWidget(
                      hintText: "Choose your location",
                      title: 'Location',
                      value: selectedLocation,
                      items: demoLocations
                          .map(
                            (e) => MenuItem(id: e, name: e),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedLocation = value),
                    ),
                    const SizedBox(height: 25),

                    ///  Dropdown for Branch
                    CustomDropdownFieldWidget(
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
                    ),
                    const SizedBox(height: 25),

                    if (savedTreatments.isNotEmpty) ...[
                      Column(
                        children: savedTreatments.map((e) {
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffF0F0F0),
                              border: Border.all(color: Color(0xffF0F0F0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Treatment: ${e.name}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Male ",
                                      style:
                                          TextStyle(color: Color(0xff006837)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        // color: Colors.green.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: Color(0xff00000033)
                                                .withOpacity(0.20)),
                                      ),
                                      child: Text(
                                        '${e.male}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff006837)),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      "Female ",
                                      style:
                                          TextStyle(color: Color(0xff006837)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        // color: Colors.pink.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: Color(0xff00000033)
                                                .withOpacity(0.20)),
                                      ),
                                      child: Text(
                                        '${e.female}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff006837)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],

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
                    AppTextFormField(
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Total Amount',
                    ),
                    const SizedBox(height: 25),
                    AppTextFormField(
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Discount Amount',
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payment Option"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Cash',
                                  groupValue: "_selectedPayment",
                                  onChanged: (value) {
                                    setState(() {
                                      // _selectedPayment = value;
                                    });
                                  },
                                ),
                                const Text('Cash'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Card',
                                  groupValue: "_selectedPayment",
                                  onChanged: (value) {
                                    setState(() {
                                      // _selectedPayment = value;
                                    });
                                  },
                                ),
                                const Text('Card'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'UPI',
                                  groupValue: "_selectedPayment",
                                  onChanged: (value) {
                                    setState(() {
                                      // _selectedPayment = value;
                                    });
                                  },
                                ),
                                const Text('UPI'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AppTextFormField(
                          fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                          title: "Advance Amount",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        AppTextFormField(
                          fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                          title: "Balance Amount",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        AppTextFormField(
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus(FocusNode()); // Hide keyboard
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                treatmentDateController.text =
                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                              });
                            }
                          },
                          controller: treatmentDateController,
                          suffixIcon: Icon(
                            Icons.date_range,
                            color: Color(0xff006837),
                          ),
                          fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                          title: "Treatement Date",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
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
                    SizedBox(
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
                    SizedBox(
                      height: 20,
                    ),
                    Text("Add patients"),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            // Left input field (e.g. "Male")
                            GenderBox(
                              gender: "Male",
                            ),

                            const Spacer(), // Push next widgets to the end

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
                                      .updateMaleCount(false);
                                  // Decrease count logic
                                },
                              ),
                            ),
                            const SizedBox(width: 6),

                            // Small counter field
                            Container(
                              width: 48,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xff000000).withOpacity(0.30),
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
                                  // Increase count logic
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            GenderBox(
                              gender: "Female",
                            ),

                            const Spacer(), // Push next widgets to the end

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

                            // Small counter field
                            Container(
                              alignment: Alignment.center,
                              width: 48,
                              height: 44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xff000000).withOpacity(0.30),
                                ),
                              ),
                              child: Consumer<TreatementController>(
                                  builder: (context, value, child) {
                                return Text(value.femaleCount.toString());
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
                                      .updateFemaleCount(true);
                                  // Increase count logic
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
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

                              setState(() {
                                print(treatment.id);
                                savedTreatments.add(TreatmentModel(
                                  idAsString: treatment.id.toString(),
                                  name: treatment.name,
                                  male: treatmentController.maleCount,
                                  female: treatmentController.femaleCount,
                                )
                                    //   {
                                    //   'id': treatment.id.toString(),
                                    //   'name': treatment.name,
                                    //   'male': treatmentController.maleCount,
                                    //   'female': treatmentController.femaleCount,
                                    // }
                                    );
                                // reset counts & selection for next time
                                treatmentController.resetGenderCount();
                                selectedTreatmentModel = null;
                              });

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

class GenderBox extends StatelessWidget {
  const GenderBox({
    super.key,
    required this.gender,
  });

  final String gender;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        top: 16.5,
        bottom: 16.5,
        right: 77,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.53),
        border: Border.all(color: Color(0xff000000).withOpacity(0.25)),
        color: Color(0xffD9D9D9).withOpacity(0.25),
      ),
      child: Text(gender),
    );
  }
}
