import 'package:ayurvedic_patients/domain/model/branch_model.dart';
import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GeneratePatientPDF {
  final TextEditingController nameController;
  final TextEditingController numberController;
  final TextEditingController addressController;
  final TextEditingController totalAmountController;
  final TextEditingController discountAmountController;
  final TextEditingController advanceAmountController;
  final TextEditingController balanceAmountController;
  final TextEditingController treatmentDateController;
  final List<TreatmentModel> savedTreatments;
  final BranchModel? selectedBranch;
  final String? selectedLocation;
  final String? selectedHour;
  final String? selectedMinute;

  GeneratePatientPDF({
    required this.nameController,
    required this.numberController,
    required this.addressController,
    required this.totalAmountController,
    required this.discountAmountController,
    required this.advanceAmountController,
    required this.balanceAmountController,
    required this.treatmentDateController,
    required this.savedTreatments,
    this.selectedBranch,
    this.selectedLocation,
    this.selectedHour,
    this.selectedMinute,
  });

  Future<void> generatePDF(Map<String, dynamic> data) async {
    final pdf = pw.Document();
    final logoImage = await _imageFromAssetBundle('assets/images/logo_image.png');
    final signatureImage = await _imageFromAssetBundle('assets/images/sign_img.png');

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

    /// SAVE PDF
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  Future<pw.ImageProvider> _imageFromAssetBundle(String path) async {
    final bytes = await rootBundle.load(path);
    return pw.MemoryImage(bytes.buffer.asUint8List());
  }
}