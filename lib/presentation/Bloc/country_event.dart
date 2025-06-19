import 'package:equatable/equatable.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object?> get props => [];
}

class FetchCountries extends CountryEvent {
  const FetchCountries();
}

class SearchCountries extends CountryEvent {
  final String query;

  const SearchCountries(this.query);

  @override
  List<Object?> get props => [query];
}

class ToggleFavoriteCountry extends CountryEvent {
  final String countryName;

  const ToggleFavoriteCountry(this.countryName);

  @override
  List<Object?> get props => [countryName];
}
