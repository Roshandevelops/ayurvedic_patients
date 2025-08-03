class PatientModel {
  final int? id;
  final String? user;
  final String? payment;
  final String? name;
  final String? phone;
  final String? address;
  final dynamic price;
  final int? totalAmount;
  final int? discountAmount;
  final int? advanceAmount;
  final int? balanceAmount;
  final DateTime? dateNdTime;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<PatientDetailModel?>? patientDetailsList;

  PatientModel({
    this.id,
    this.user,
    this.payment,
    this.name,
    this.phone,
    this.address,
    this.price,
    this.totalAmount,
    this.discountAmount,
    this.advanceAmount,
    this.balanceAmount,
    this.dateNdTime,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.patientDetailsList,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        id: json["id"],
        user: json["user"],
        payment: json["payment"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        price: json["price"],
        totalAmount: json["total_amount"],
        discountAmount: json["discount_amount"],
        advanceAmount: json["advance_amount"],
        balanceAmount: json["balance_amount"],
        dateNdTime: json["date_nd_time"] == null
            ? null
            : DateTime.parse(json["date_nd_time"]),
        isActive: json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(
                json["updated_at"],
              ),
        patientDetailsList: json["patientdetails_set"] == null
            ? null
            : (json["patientdetails_set"] as List).map((e) {
               
                return PatientDetailModel.fromJson(e);
              }).toList(),
      );
}

class PatientDetailModel {
  PatientDetailModel({
    this.femaleCount,
    this.id,
    this.maleCount,
    this.patientId,
    this.treatmentId,
    this.treatmentName,
  });

  final int? id;
  final String? maleCount;
  final String? femaleCount;
  final int? patientId;
  final int? treatmentId;
  final String? treatmentName;

  factory PatientDetailModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailModel(
      id: json["id"],
      maleCount: json["male"],
      femaleCount: json["female"],
      patientId: json["patient"],
      treatmentId: json["treatment"],
      treatmentName: json["treatment_name"],
    );
  }
}
