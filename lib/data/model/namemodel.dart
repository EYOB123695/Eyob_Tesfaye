// lib/data/models/name_model.dart

class NameModel {
  final String common;

  NameModel({required this.common});

  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(
      common: json['common'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'common': common,
    };
  }
}
