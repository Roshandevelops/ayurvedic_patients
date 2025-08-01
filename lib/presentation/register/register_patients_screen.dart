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
  // List<Treatment>treatMents=[];

  void fetchBracnhes() async {
    await Provider.of<TreatementController>(context, listen: false)
        .getAllTreatements();
    await Provider.of<BranchController>(context, listen: false).getBranch();
  }

  final List<String> demoLocations = ['Wayanad', 'Kozhikode', 'Kannur'];

  TextEditingController treatmentDateController = TextEditingController();

  MenuItem? selectedLocation;
  MenuItem? selectedBranch;
  String? selectedTreatement;
  MenuItem? selectedTreatementModel;
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
                          .map((e) => MenuItem(
                              id: e.id.toString(), name: e.name.toString()))
                          .toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            selectedBranch = val;
                          },
                        );

                        log("Selected Branch ID: ${selectedBranch?.id}");
                      },
                    ),
                    const SizedBox(height: 25),

                    /// Add Treatement
                    /// Te
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          bottomSheet();
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
                                      selectedTreatementModel = value;
                                    });
                                  },
                                  title: "Treatement Time",
                                  value: selectedTreatementModel),
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
                                      selectedTreatementModel = value;
                                    });
                                  },
                                  value: selectedTreatementModel),
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
                        onPressed: () {},
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

  void bottomSheet() {
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
                              .map((e) => MenuItem(
                                  id: e.id.toString(), name: e.name.toString()))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedTreatementModel = value;
                            });
                          },
                          title: "Choose Treatement",
                          value: selectedTreatementModel);
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: AppTextFormField(
                                fillColor: Color(0xffD9D9D9).withOpacity(0.25),
                                hint: 'Male',
                              ),
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
                                  // Decrease count logic
                                },
                              ),
                            ),
                            const SizedBox(width: 6),

                            // Small counter field
                            SizedBox(
                              width: 50,
                              height: 40,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                // initialValue: '1',
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    // borderSide: BorderSide.,
                                  ),
                                ),
                              ),
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
                            // Left input field (e.g. "Male")
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: AppTextFormField(
                                fillColor: Color(0xffD9D9D9).withOpacity(0.25),
                                hint: 'Female',
                              ),
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
                                  // Decrease count logic
                                },
                              ),
                            ),
                            const SizedBox(width: 6),

                            // Small counter field
                            SizedBox(
                              width: 50,
                              height: 40,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                // initialValue: '1',
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    // borderSide: BorderSide.,
                                  ),
                                ),
                              ),
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
                                  // Increase count logic
                                },
                              ),
                            ),
                          ],
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
