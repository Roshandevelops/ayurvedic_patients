import 'dart:developer';

import 'package:ayurvedic_patients/domain/model/branch_model.dart';
import 'package:ayurvedic_patients/domain/model/patient_model.dart';
import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:ayurvedic_patients/infrastructure/branch_controller.dart';
import 'package:ayurvedic_patients/infrastructure/treatement_controller.dart';
import 'package:ayurvedic_patients/infrastructure/update_patient_controller.dart';
import 'package:ayurvedic_patients/presentation/register/widget/add_treatment_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/date_picker_field_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/location_branch_dropdown_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/payment_radio_button_widget.dart';
import 'package:ayurvedic_patients/presentation/register/widget/saved_treatments.dart';
import 'package:ayurvedic_patients/presentation/register/widget/treatement_time_widget.dart';
import 'package:ayurvedic_patients/presentation/widget/app_elevated_button.dart';
import 'package:ayurvedic_patients/utils/color_constants.dart';
import 'package:ayurvedic_patients/utils/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:ayurvedic_patients/presentation/widget/app_textformfield.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
    await Provider.of<BranchController>(context, listen: false).getBranch();
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

  PatientModel? patientModel;
  //TreatmentModel? treatmentModel;

  String? selectedLocation;
  // String? selectedTreatmentModel;

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
                          print("testing $treatmentIDs");
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

                          log(nameController.text);
                          log(numberController.text);
                          log(addressController.text);
                          log(selectedLocation ?? "Not selected Location");
                          log(selectedTreatmentIDs.toString());
                          log(selectedBranch?.name ?? "Unknown");
                          log(totalAmountController.text);
                          log(discountAmountController.text);
                          log(advanceAmountController.text);
                          log(balanceAmountController.text);
                          log(treatmentDateController.text);

                          if (treatmentIDs.isEmpty ||
                              nameController.text.isEmpty ||
                              numberController.text.isEmpty ||
                              addressController.text.isEmpty ||
                              selectedBranch?.id == null ||
                              selectedLocation == null ||
                              totalAmountController.text.isEmpty ||
                              discountAmountController.text.isEmpty ||
                              balanceAmountController.text.isEmpty ||
                              treatmentDateController.text.isEmpty) {
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
                            generatePatientPDF(data);
                          }
                        },
                        buttonText: "Save",
                        textStyle:
                            const TextStyle(color: ColorConstants.kWhiteColor),
                        backgroundColor:
                            ColorConstants.elevatedButtonGreenColor,
                      ),
                    ),
                    SizeConstants.kHeight20,
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

  Future<void> generatePatientPDF(Map<String, dynamic> data) async {
    final pdf = pw.Document();
    final logoImage =
        await imageFromAssetBundle('assets/images/logo_image.png');
    final signatureImage =
        await imageFromAssetBundle('assets/images/sign_img.png');

    final columnWidths = {
      'treatment': 120.0,
      'price': 100.0,
      'male': 100.0,
      'female': 100.0,
      'total': 100.0,
    };

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              /// Header with Logo and Branch Info
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(logoImage, width: 60),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        selectedBranch?.name.toString() ?? "Unknown",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        selectedBranch?.address.toString() ?? "Unknown",
                        style: const pw.TextStyle(color: PdfColors.grey),
                      ),
                      pw.Text(
                        selectedBranch?.mail.toString() ?? "Unknown",
                        style: const pw.TextStyle(color: PdfColors.grey),
                      ),
                      pw.Text(
                        "Mob: ${selectedBranch?.phone.toString()} | ${selectedBranch?.phone ?? "Unknown"}",
                        style: const pw.TextStyle(color: PdfColors.grey),
                      ),
                      pw.Text(
                        "GST NO: ${selectedBranch?.gst ?? "32AABCU9603R1ZW"}",
                        style: const pw.TextStyle(color: PdfColors.black),
                      ),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 10),
              pw.Divider(color: PdfColors.grey),
              pw.SizedBox(height: 10),

              /// Patient Details Section
              pw.Text(
                "Patient Details",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.green,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Name",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Address",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Whatsapp Number",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(nameController.text),
                        pw.SizedBox(height: 10),
                        pw.Text(addressController.text),
                        pw.SizedBox(height: 10),
                        pw.Text(numberController.text),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Booked On",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Treatment Date",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Treatment Time",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(treatmentDateController.text),
                        pw.SizedBox(height: 10),
                        pw.Text(treatmentDateController.text),
                        pw.SizedBox(height: 10),
                        pw.Text(treatmentDateController.text),
                      ],
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),

              /// Row for Treatment Table
              pw.Row(
                children: [
                  pw.SizedBox(
                    width: columnWidths['treatment'],
                    child: pw.Text("Treatment",
                        style: pw.TextStyle(
                          color: PdfColors.green,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ),
                  pw.SizedBox(
                    width: columnWidths['price'],
                    child: pw.Text("Price",
                        style: pw.TextStyle(
                          color: PdfColors.green,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ),
                  pw.SizedBox(
                    width: columnWidths['male'],
                    child: pw.Text("Male",
                        style: pw.TextStyle(
                          color: PdfColors.green,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ),
                  pw.SizedBox(
                    width: columnWidths['female'],
                    child: pw.Text("Female",
                        style: pw.TextStyle(
                          color: PdfColors.green,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ),
                  pw.SizedBox(
                    width: columnWidths['total'],
                    child: pw.Text("Total",
                        style: pw.TextStyle(
                          color: PdfColors.green,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ),
                ],
              ),

              // Treatment List
              pw.ListView.builder(
                itemCount: savedTreatments.length,
                itemBuilder: (context, index) {
                  return pw.Column(
                    children: [
                      pw.SizedBox(height: 10),
                      pw.Row(
                        children: [
                          pw.SizedBox(
                            width: columnWidths['treatment'],
                            child: pw.Text(
                                savedTreatments[index].name ?? "Unknown"),
                          ),
                          pw.SizedBox(
                            width: columnWidths['price'],
                            child:
                                pw.Text(savedTreatments[index].price ?? "500"),
                          ),
                          pw.SizedBox(
                            width: columnWidths['male'],
                            child:
                                pw.Text(savedTreatments[index].male.toString()),
                          ),
                          pw.SizedBox(
                            width: columnWidths['female'],
                            child: pw.Text(
                                savedTreatments[index].female.toString()),
                          ),
                          pw.SizedBox(
                            width: columnWidths['total'],
                            child: pw.Text(totalAmountController.text),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              pw.SizedBox(height: 20),

              pw.Divider(),
              pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text("Total Amount",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 30),
                      pw.Text(totalAmountController.text),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text("Discount"),
                      pw.SizedBox(width: 30),
                      pw.Text(discountAmountController.text),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text("Advance"),
                      pw.SizedBox(width: 30),
                      pw.Text(advanceAmountController.text),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                ],
              ),
              pw.Divider(
                indent: 350,
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text("Balance",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(width: 30),
                  pw.Text(balanceAmountController.text),
                ],
              ),
              pw.SizedBox(height: 50),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    "Thank you for choosing us",
                    style: pw.TextStyle(
                      color: PdfColors.green,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                      "Your well-being is our commitment, and we're honored\nyou've entrusted us with your healthy journey"),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Image(signatureImage, width: 60),
                  pw.SizedBox(width: 50),
                ],
              ),
            ],
          );
        },
      ),
    );

    /// SAVE

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  Future<pw.ImageProvider> imageFromAssetBundle(String path) async {
    final bytes = await rootBundle.load(path);
    return pw.MemoryImage(bytes.buffer.asUint8List());
  }
}
