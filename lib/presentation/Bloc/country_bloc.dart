import 'package:bloc/bloc.dart';
import 'package:eyobtesfaye/domain/entities/countryentity.dart';
import 'package:dartz/dartz.dart';
import 'package:eyobtesfaye/core/error/failure.dart';
import 'package:eyobtesfaye/domain/usecase/usecases.dart';
import 'country_event.dart';
import 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final GetAllCountriesUseCase getAllCountries;
  final SearchCountriesUseCase searchCountries;
  final AddToFavoritesUseCase addToFavorites;
  final RemoveFromFavoritesUseCase removeFromFavorites;
  final Set<String> _favorites = {};
  List<CountryEntity> _allCountries = [];

  CountryBloc({
    required this.getAllCountries,
    required this.searchCountries,
    required this.addToFavorites,
    required this.removeFromFavorites,
  }) : super(CountryInitial()) {
    on<FetchCountries>(_onFetchCountries);
    on<SearchCountries>(_onSearchCountries);
    on<ToggleFavoriteCountry>(_onToggleFavoriteCountry);
  }

  Future<void> _onFetchCountries(
      FetchCountries event, Emitter<CountryState> emit) async {
    emit(CountryLoading());
    final failureOrCountries = await getAllCountries.execute();

    failureOrCountries.fold(
      (failure) => emit(CountryError(_mapFailureToMessage(failure))),
      (countries) {
        _allCountries = countries;
        emit(CountryLoaded(
          countries: countries,
          filteredCountries: countries,
          favoriteCountryNames: _favorites,
        ));
      },
    );
  }

  Future<void> _onSearchCountries(
      SearchCountries event, Emitter<CountryState> emit) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      // If query is empty, show all countries
      emit(CountryLoaded(
        countries: _allCountries,
        filteredCountries: _allCountries,
        favoriteCountryNames: _favorites,
      ));
      return;
    }

    emit(CountryLoading());
    final failureOrCountries = await searchCountries.execute(query);

    failureOrCountries.fold(
      (failure) => emit(CountryError(_mapFailureToMessage(failure))),
      (countries) {
        if (countries.isEmpty) {
          emit(CountryEmptyResult());
        } else {
          emit(CountryLoaded(
            countries: _allCountries,
            filteredCountries: countries,
            favoriteCountryNames: _favorites,
          ));
        }
      },
    );
  }

  Future<void> _onToggleFavoriteCountry(
      ToggleFavoriteCountry event, Emitter<CountryState> emit) async {
    final countryName = event.countryName;

    if (_favorites.contains(countryName)) {
      final result = await removeFromFavorites.execute(
        _allCountries.firstWhere((c) => c.name == countryName),
      );
      result.fold(
        (_) {},
        (_) => _favorites.remove(countryName),
      );
    } else {
      final result = await addToFavorites.execute(
        _allCountries.firstWhere((c) => c.name == countryName),
      );
      result.fold(
        (_) {},
        (_) => _favorites.add(countryName),
      );
    }

    if (state is CountryLoaded) {
      final currentState = state as CountryLoaded;
      emit(CountryLoaded(
        countries: currentState.countries,
        filteredCountries: currentState.filteredCountries,
        favoriteCountryNames: _favorites,
      ));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.toString();
  }
}
