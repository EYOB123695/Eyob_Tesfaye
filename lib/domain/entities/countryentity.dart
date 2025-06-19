// lib/domain/entities/country_entity.dart

class CountryEntity {
  final String name;
  final String flag;
  final double area;
  final String region;
  final String subregion;
  final int population;
  final List<String> timezones;

  CountryEntity({
    required this.name,
    required this.flag,
    required this.area,
    required this.region,
    required this.subregion,
    required this.population,
    required this.timezones,
  });
}
