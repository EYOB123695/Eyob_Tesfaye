// lib/data/models/country_model.dart

import 'package:eyobtesfaye/data/model/namemodel.dart';
import 'package:eyobtesfaye/domain/entities/countryentity.dart';



class CountryModel {
  final NameModel name;
  final String flag;
  final double area;
  final String region;
  final String subregion;
  final int population;
  final List<String> timezones;

  CountryModel({
    required this.name,
    required this.flag,
    required this.area,
    required this.region,
    required this.subregion,
    required this.population,
    required this.timezones,
  });

  /// Convert from API JSON
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: NameModel.fromJson(json['name']),
      flag: json['flags']?['png'] ?? '',
      area: (json['area'] ?? 0).toDouble(),
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      population: json['population'] ?? 0,
      timezones: List<String>.from(json['timezones'] ?? []),
    );
  }

  /// Convert to JSON (for local storage)
  Map<String, dynamic> toJson() {
    return {
      'name': name.toJson(),
      'flags': {'png': flag},
      'area': area,
      'region': region,
      'subregion': subregion,
      'population': population,
      'timezones': timezones,
    };
  }

  /// Convert to entity for domain layer
  CountryEntity toEntity() {
    return CountryEntity(
      name: name.common,
      flag: flag,
      area: area,
      region: region,
      subregion: subregion,
      population: population,
      timezones: timezones,
    );
  }

  /// Create model from domain entity (e.g. for saving locally)
  factory CountryModel.fromEntity(CountryEntity entity) {
    return CountryModel(
      name: NameModel(common: entity.name),
      flag: entity.flag,
      area: entity.area,
      region: entity.region,
      subregion: entity.subregion,
      population: entity.population,
      timezones: entity.timezones,
    );
  }
}
