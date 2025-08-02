import 'dart:developer';

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
    //  this.nameController,
    //  this.addressController,
    //  this.advanceAmountController,
    //  this.balanceAmountController,
    //  this.discountAmountController,
    //  this.numberController,
    //  this.totalAmountController,
    //  this.treatmentDateController
  });
  // final TextEditingController? nameController;
  // final TextEditingController? numberController;
  // final TextEditingController? addressController;
  // final TextEditingController? totalAmountController;
  // final TextEditingController? discountAmountController;
  // final TextEditingController? advanceAmountController;
  // final TextEditingController? balanceAmountController;
  // final TextEditingController? treatmentDateController;

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
                        onPressed: () async {
                          print(savedTreatments.length);
                          List<String?> selectedTreatmentIDS =
                              savedTreatments.map((e) => e.idAsString).toList();
                          String treatmentIDs = selectedTreatmentIDS
                              .whereType<String>()
                              .join(',');
                          print("testing $treatmentIDs");

                          Provider.of<UpdatePatientController>(context,
                                  listen: false)
                              .submitPatientData(
                            data: data,
                          );

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
                              "date_nd_time": "01/08/2025-10:24 AM",
                              "id": "",
                              "male": "2,3",
                              "female": "4",
                              "branch": selectedBranchID.toString(),
                              "treatments": treatmentIDs,
                            },
                          );
                          log(nameController.text);
                          log(numberController.text);
                          log(addressController.text);
                          log(selectedLocation ?? "Not selected Location");
                          log(selectedBranchID ?? "Not selected Branch");
                          log(totalAmountController.text);
                          log(discountAmountController.text);
                          log(advanceAmountController.text);
                          log(balanceAmountController.text);
                          log(treatmentDateController.text);

                          if (nameController.text.isEmpty ||
                                  numberController.text.isEmpty ||
                                  addressController.text.isEmpty ||
                                  selectedBranchID == null ||
                                  selectedLocation == null ||
                                  totalAmountController.text.isEmpty ||
                                  discountAmountController.text.isEmpty ||
                                  balanceAmountController.text.isEmpty
                              // ||
                              // treatmentDateController.text.isEmpty
                              ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please fill all required fields'),
                              ),
                            );
                            return;
                          } else {
                            PatientPdfGenerator();

                            // generatePatientPDF(data);
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

  // Future<void> generatePatientPDF(Map<String, dynamic> data) async {
  //   final pdf = pw.Document();
  //   final logoImage =
  //       await imageFromAssetBundle('assets/images/logo_image.png');
  //   final signatureImage =
  //       await imageFromAssetBundle('assets/images/sign_img.png');

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (pw.Context context) {
  //         return pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //               children: [
  //                 pw.Image(logoImage, width: 60),
  //                 pw.Column(
  //                   crossAxisAlignment: pw.CrossAxisAlignment.end,
  //                   children: [
  //                     pw.Text("KUMARAKOM",
  //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //                     pw.Text(
  //                         "Cheepunkal P.O Kumarakom, Kottayam, Kerala-686561"),
  //                     pw.Text(
  //                       "email: unknown@gmail.com",
  //                       style: pw.TextStyle(color: PdfColors.grey),
  //                     ),
  //                     pw.Text(
  //                       "Mob +91904893451 |+919033490374",
  //                       style: pw.TextStyle(color: PdfColors.grey),
  //                     ),
  //                     pw.Text(
  //                       "GST No:2398HFE8933U",
  //                       style: pw.TextStyle(color: PdfColors.black),
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //             pw.SizedBox(height: 10),
  //             pw.Divider(),
  //             pw.SizedBox(height: 10),
  //             pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 pw.Text(
  //                   "Patient Details",
  //                   style: pw.TextStyle(
  //                       fontWeight: pw.FontWeight.bold, color: PdfColors.green),
  //                 ),
  //                 pw.SizedBox(height: 10),
  //                 pw.Column(
  //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                   children: [
  //                     pw.Table(
  //                       columnWidths: {
  //                         0: pw.FlexColumnWidth(2),
  //                         1: pw.FlexColumnWidth(3),
  //                         2: pw.FlexColumnWidth(2),
  //                         3: pw.FlexColumnWidth(3),
  //                       },
  //                       children: [
  //                         pw.TableRow(
  //                           children: [
  //                             pw.Text("Name",
  //                                 style: pw.TextStyle(
  //                                     fontSize: 10,
  //                                     fontWeight: pw.FontWeight.bold)),
  //                             pw.Text(nameController.text,
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("Booked on",
  //                                 style: pw.TextStyle(
  //                                     fontSize: 10,
  //                                     fontWeight: pw.FontWeight.bold)),
  //                             pw.Text("31/12/2024  |  12:12pm",
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                           ],
  //                         ),
  //                       ],
  //                     ),

  //                     pw.SizedBox(height: 10), // 👈 space between rows

  //                     pw.Table(
  //                       columnWidths: {
  //                         0: pw.FlexColumnWidth(2),
  //                         1: pw.FlexColumnWidth(3),
  //                         2: pw.FlexColumnWidth(2),
  //                         3: pw.FlexColumnWidth(3),
  //                       },
  //                       children: [
  //                         pw.TableRow(
  //                           children: [
  //                             pw.Text("Address",
  //                                 style: pw.TextStyle(
  //                                     fontSize: 10,
  //                                     fontWeight: pw.FontWeight.bold)),
  //                             pw.Text(addressController.text,
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("Treatment Date",
  //                                 style: pw.TextStyle(
  //                                     fontSize: 10,
  //                                     fontWeight: pw.FontWeight.bold)),
  //                             pw.Text("31/12/2024",
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                           ],
  //                         ),
  //                       ],
  //                     ),

  //                     pw.SizedBox(height: 10),

  //                     pw.Table(
  //                       columnWidths: {
  //                         0: pw.FlexColumnWidth(2),
  //                         1: pw.FlexColumnWidth(3),
  //                         2: pw.FlexColumnWidth(2),
  //                         3: pw.FlexColumnWidth(3),
  //                       },
  //                       children: [
  //                         pw.TableRow(
  //                           children: [
  //                             pw.Text("Whatsapp Number",
  //                                 style: pw.TextStyle(
  //                                     fontSize: 10,
  //                                     fontWeight: pw.FontWeight.bold)),
  //                             pw.Text(numberController.text,
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("Treatment Time",
  //                                 style: pw.TextStyle(
  //                                     fontSize: 10,
  //                                     fontWeight: pw.FontWeight.bold)),
  //                             pw.Text("11:00 am",
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 pw.SizedBox(height: 10),
  //                 pw.Divider(),
  //                 pw.SizedBox(height: 10),
  //                 pw.Column(
  //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                   children: [
  //                     pw.Table(
  //                       columnWidths: {
  //                         0: pw.FlexColumnWidth(2),
  //                         1: pw.FlexColumnWidth(3),
  //                         2: pw.FlexColumnWidth(2),
  //                         3: pw.FlexColumnWidth(3),
  //                       },
  //                       children: [
  //                         pw.TableRow(
  //                           children: [
  //                             pw.Text("Treatment",
  //                                 style: pw.TextStyle(
  //                                     fontSize: 10,
  //                                     fontWeight: pw.FontWeight.bold,
  //                                     color: PdfColors.green)),
  //                             pw.Text(
  //                               "Price",
  //                               style: pw.TextStyle(
  //                                 fontSize: 10,
  //                                 color: PdfColors.green,
  //                                 fontWeight: pw.FontWeight.bold,
  //                               ),
  //                             ),
  //                             pw.Text(
  //                               "Male",
  //                               style: pw.TextStyle(
  //                                 fontSize: 10,
  //                                 color: PdfColors.green,
  //                                 fontWeight: pw.FontWeight.bold,
  //                               ),
  //                             ),
  //                             pw.Text(
  //                               "Female",
  //                               style: pw.TextStyle(
  //                                 fontSize: 10,
  //                                 color: PdfColors.green,
  //                                 fontWeight: pw.FontWeight.bold,
  //                               ),
  //                             ),
  //                             pw.Text(
  //                               "Total",
  //                               style: pw.TextStyle(
  //                                 fontSize: 10,
  //                                 color: PdfColors.green,
  //                                 fontWeight: pw.FontWeight.bold,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     pw.SizedBox(height: 10),
  //                     pw.Table(
  //                       columnWidths: {
  //                         0: pw.FlexColumnWidth(2),
  //                         1: pw.FlexColumnWidth(3),
  //                         2: pw.FlexColumnWidth(2),
  //                         3: pw.FlexColumnWidth(3),
  //                       },
  //                       children: [
  //                         pw.TableRow(
  //                           children: [
  //                             pw.Text("panchakarma",
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("200", style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("4", style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("4", style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text(totalAmountController.text,
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     pw.SizedBox(height: 10),
  //                     pw.Table(
  //                       columnWidths: {
  //                         0: pw.FlexColumnWidth(2),
  //                         1: pw.FlexColumnWidth(3),
  //                         2: pw.FlexColumnWidth(2),
  //                         3: pw.FlexColumnWidth(3),
  //                       },
  //                       children: [
  //                         pw.TableRow(
  //                           children: [
  //                             pw.Text("panchakarma",
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("200", style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("4", style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("4", style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text(totalAmountController.text,
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     pw.SizedBox(height: 10),
  //                     pw.Table(
  //                       columnWidths: {
  //                         0: pw.FlexColumnWidth(2),
  //                         1: pw.FlexColumnWidth(3),
  //                         2: pw.FlexColumnWidth(2),
  //                         3: pw.FlexColumnWidth(3),
  //                       },
  //                       children: [
  //                         pw.TableRow(
  //                           children: [
  //                             pw.Text("panchakarma",
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("200", style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("4", style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text("4", style: pw.TextStyle(fontSize: 10)),
  //                             pw.Text(totalAmountController.text,
  //                                 style: pw.TextStyle(fontSize: 10)),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     pw.SizedBox(height: 10),
  //                     pw.Divider(),
  //                     pw.SizedBox(height: 10),
  //                     pw.Column(
  //                       children: [
  //                         pw.Row(
  //                           mainAxisAlignment: pw.MainAxisAlignment.end,
  //                           children: [
  //                             pw.Text("Total amount",
  //                                 style: pw.TextStyle(
  //                                     fontWeight: pw.FontWeight.bold)),
  //                             pw.SizedBox(width: 30),
  //                             pw.Text(totalAmountController.text,
  //                                 style: pw.TextStyle(
  //                                     fontWeight: pw.FontWeight.bold)),
  //                           ],
  //                         ),
  //                         pw.SizedBox(
  //                           height: 10,
  //                         ),
  //                         pw.Row(
  //                           mainAxisAlignment: pw.MainAxisAlignment.end,
  //                           children: [
  //                             pw.Text("Discount"),
  //                             pw.SizedBox(width: 30),
  //                             pw.Text(discountAmountController.text),
  //                           ],
  //                         ),
  //                         pw.SizedBox(
  //                           height: 10,
  //                         ),
  //                         pw.Row(
  //                           mainAxisAlignment: pw.MainAxisAlignment.end,
  //                           children: [
  //                             pw.Text("Advance"),
  //                             pw.SizedBox(width: 30),
  //                             pw.Text(advanceAmountController.text),
  //                           ],
  //                         ),
  //                         pw.SizedBox(height: 10),
  //                         pw.Divider(),
  //                         pw.SizedBox(height: 10),
  //                         pw.Row(
  //                           mainAxisAlignment: pw.MainAxisAlignment.end,
  //                           children: [
  //                             pw.Text("Balance",
  //                                 style: pw.TextStyle(
  //                                     fontWeight: pw.FontWeight.bold)),
  //                             pw.SizedBox(width: 30),
  //                             pw.Text(balanceAmountController.text,
  //                                 style: pw.TextStyle(
  //                                     fontWeight: pw.FontWeight.bold)),
  //                           ],
  //                         ),
  //                         pw.SizedBox(height: 60),
  //                         pw.Row(
  //                           mainAxisAlignment: pw.MainAxisAlignment.end,
  //                           children: [
  //                             pw.Text("Thank you for choosing us",
  //                                 style: pw.TextStyle(
  //                                   color: PdfColors.green,
  //                                   fontSize: 25,
  //                                   fontWeight: pw.FontWeight.bold,
  //                                 )),
  //                           ],
  //                         ),
  //                         pw.SizedBox(height: 20),
  //                         pw.Row(
  //                           mainAxisAlignment: pw.MainAxisAlignment.end,
  //                           children: [
  //                             pw.Text(
  //                               "Your well being is our commitment,and we are honored\nyou've entrusted us with your health journey",
  //                             ),
  //                           ],
  //                         ),
  //                         pw.SizedBox(
  //                           height: 30,
  //                         ),
  //                         pw.Row(
  //                           mainAxisAlignment: pw.MainAxisAlignment.end,
  //                           children: [
  //                             pw.Image(
  //                               signatureImage,
  //                               width: 120,
  //                             ),
  //                             pw.SizedBox(
  //                               width: 40,
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             )
  //           ],
  //         );
  //       },
  //     ),
  //   );
  //   await Printing.layoutPdf(
  //     onLayout: (format) async => pdf.save(),
  //   );
  // }

  //   Future<pw.ImageProvider> imageFromAssetBundle(String path) async {
  //   final bytes = await rootBundle.load(path);
  //   return pw.MemoryImage(bytes.buffer.asUint8List());
  // }
}

class PatientPdfGenerator {
  static Future<void> generatePDF(Map<String, dynamic> data) async {
    final pdf = pw.Document();
    final logoImage =
        await _imageFromAssetBundle('assets/images/logo_image.png');
    final signatureImage =
        await _imageFromAssetBundle('assets/images/sign_img.png');

    final nameController = data['nameController'];
    final addressController = data['addressController'];
    final numberController = data['numberController'];
    final totalAmountController = data['totalAmountController'];
    final discountAmountController = data['discountAmountController'];
    final advanceAmountController = data['advanceAmountController'];
    final balanceAmountController = data['balanceAmountController'];

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(logoImage, width: 60),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text("KUMARAKOM",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                          "Cheepunkal P.O Kumarakom, Kottayam, Kerala-686561"),
                      pw.Text(
                        "email: unknown@gmail.com",
                        style: pw.TextStyle(color: PdfColors.grey),
                      ),
                      pw.Text(
                        "Mob +91904893451 |+919033490374",
                        style: pw.TextStyle(color: PdfColors.grey),
                      ),
                      pw.Text(
                        "GST No:2398HFE8933U",
                        style: pw.TextStyle(color: PdfColors.black),
                      ),
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "Patient Details",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, color: PdfColors.green),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildPatientInfoTableRow("Name", nameController.text,
                          "Booked on", "31/12/2024  |  12:12pm"),
                      pw.SizedBox(height: 10),
                      _buildPatientInfoTableRow(
                          "Address",
                          addressController.text,
                          "Treatment Date",
                          "31/12/2024"),
                      pw.SizedBox(height: 10),
                      _buildPatientInfoTableRow("Whatsapp Number",
                          numberController.text, "Treatment Time", "11:00 am"),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Divider(),
                  pw.SizedBox(height: 10),
                  _buildTreatmentHeader(),
                  pw.SizedBox(height: 10),
                  _buildTreatmentRow("panchakarma", "200", "4", "4",
                      totalAmountController.text),
                  pw.SizedBox(height: 10),
                  _buildTreatmentRow("panchakarma", "200", "4", "4",
                      totalAmountController.text),
                  pw.SizedBox(height: 10),
                  _buildTreatmentRow("panchakarma", "200", "4", "4",
                      totalAmountController.text),
                  pw.SizedBox(height: 10),
                  pw.Divider(),
                  pw.SizedBox(height: 10),
                  _buildSummarySection(
                    totalAmountController.text,
                    discountAmountController.text,
                    advanceAmountController.text,
                    balanceAmountController.text,
                    signatureImage,
                  ),
                ],
              )
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  static pw.Table _buildPatientInfoTableRow(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    return pw.Table(
      columnWidths: {
        0: pw.FlexColumnWidth(2),
        1: pw.FlexColumnWidth(3),
        2: pw.FlexColumnWidth(2),
        3: pw.FlexColumnWidth(3),
      },
      children: [
        pw.TableRow(
          children: [
            pw.Text(label1,
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
            pw.Text(value1, style: pw.TextStyle(fontSize: 10)),
            pw.Text(label2,
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
            pw.Text(value2, style: pw.TextStyle(fontSize: 10)),
          ],
        ),
      ],
    );
  }

  static pw.Table _buildTreatmentHeader() {
    return pw.Table(
      columnWidths: {
        0: pw.FlexColumnWidth(2),
        1: pw.FlexColumnWidth(2),
        2: pw.FlexColumnWidth(1),
        3: pw.FlexColumnWidth(1),
        4: pw.FlexColumnWidth(2),
      },
      children: [
        pw.TableRow(
          children: [
            pw.Text("Treatment",
                style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green)),
            pw.Text("Price",
                style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green)),
            pw.Text("Male",
                style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green)),
            pw.Text("Female",
                style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green)),
            pw.Text("Total",
                style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green)),
          ],
        ),
      ],
    );
  }

  static pw.Table _buildTreatmentRow(String treatment, String price,
      String male, String female, String total) {
    return pw.Table(
      columnWidths: {
        0: pw.FlexColumnWidth(2),
        1: pw.FlexColumnWidth(2),
        2: pw.FlexColumnWidth(1),
        3: pw.FlexColumnWidth(1),
        4: pw.FlexColumnWidth(2),
      },
      children: [
        pw.TableRow(
          children: [
            pw.Text(treatment, style: pw.TextStyle(fontSize: 10)),
            pw.Text(price, style: pw.TextStyle(fontSize: 10)),
            pw.Center(child: pw.Text(male, style: pw.TextStyle(fontSize: 10))),
            pw.Center(
                child: pw.Text(female, style: pw.TextStyle(fontSize: 10))),
            pw.Text(total, style: pw.TextStyle(fontSize: 10)),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildSummarySection(
    String total,
    String discount,
    String advance,
    String balance,
    pw.ImageProvider signatureImage,
  ) {
    return pw.Column(
      children: [
        _buildSummaryRow("Total amount", total, isBold: true),
        pw.SizedBox(height: 10),
        _buildSummaryRow("Discount", discount),
        pw.SizedBox(height: 10),
        _buildSummaryRow("Advance", advance),
        pw.SizedBox(height: 10),
        pw.Divider(),
        pw.SizedBox(height: 10),
        _buildSummaryRow("Balance", balance, isBold: true),
        pw.SizedBox(height: 60),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text("Thank you for choosing us",
                style: pw.TextStyle(
                  color: PdfColors.green,
                  fontSize: 25,
                  fontWeight: pw.FontWeight.bold,
                )),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text(
              "Your well being is our commitment,\nand we are honored you've entrusted us with your health journey",
            ),
          ],
        ),
        pw.SizedBox(height: 30),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Image(signatureImage, width: 120),
            pw.SizedBox(width: 40),
          ],
        ),
      ],
    );
  }

  static pw.Row _buildSummaryRow(String label, String value,
      {bool isBold = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Text(label,
            style: pw.TextStyle(
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            )),
        pw.SizedBox(width: 30),
        pw.Text(value,
            style: pw.TextStyle(
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            )),
      ],
    );
  }

  static Future<pw.ImageProvider> _imageFromAssetBundle(String path) async {
    final bytes = await rootBundle.load(path);
    return pw.MemoryImage(bytes.buffer.asUint8List());
  }
}
