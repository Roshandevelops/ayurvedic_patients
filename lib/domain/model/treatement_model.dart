class TreatmentModel {
  final int? id;
   final String? idAsString;
  final String? name;
  final String? duration;
  final String? price;
  final bool? isActive;
  final int? male;
  final int? female;
  final String? createdAt;
  final String? updatedAt;

  TreatmentModel({
    this.id,
    this.name,
    this.duration,
    this.price,
    this.idAsString,
    this.isActive,
    this.male,
    this.female,
    this.createdAt,
    this.updatedAt,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) {
    return TreatmentModel(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      price: json['price'],
      isActive: json['is_active'],
      // male: json['male'],
      // female: json['female'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
