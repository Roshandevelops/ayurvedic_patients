class TreatmentModel {
  final int id;
  final String name;
  final String duration;
  final String price;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  TreatmentModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) {
    return TreatmentModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      duration: json['duration'] ?? '',
      price: json['price'] ?? '',
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
