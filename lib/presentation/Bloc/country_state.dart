// country_state.dart

import 'package:equatable/equatable.dart';
import 'package:eyobtesfaye/domain/entities/countryentity.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object?> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  final List<CountryEntity> countries;
  final List<CountryEntity> filteredCountries;
  final Set<String> favoriteCountryNames;

  const CountryLoaded({
    required this.countries,
    required this.filteredCountries,
    required this.favoriteCountryNames,
  });

  @override
  List<Object?> get props => [countries, filteredCountries, favoriteCountryNames];
}

class CountryError extends CountryState {
  final String message;

  const CountryError(this.message);

  @override
  List<Object?> get props => [message];
}

class CountryEmptyResult extends CountryState {}
