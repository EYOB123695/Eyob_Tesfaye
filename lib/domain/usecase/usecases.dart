import 'package:dartz/dartz.dart';
import 'package:eyobtesfaye/core/error/failure.dart';
import 'package:eyobtesfaye/domain/entities/countryentity.dart';
import 'package:eyobtesfaye/domain/repository/countryrepository.dart';

/// Use case for fetching all countries
class GetAllCountriesUseCase {
  final CountryRepository repository;

  GetAllCountriesUseCase(this.repository);

  Future<Either<Failure, List<CountryEntity>>> execute() {
    return repository.getAllCountries();
  }
}

/// Use case for searching countries by query
class SearchCountriesUseCase {
  final CountryRepository repository;

  SearchCountriesUseCase(this.repository);

  Future<Either<Failure, List<CountryEntity>>> execute(String query) {
    return repository.searchCountries(query);
  }
}

/// Use case for adding a country to favorites
class AddToFavoritesUseCase {
  final CountryRepository repository;

  AddToFavoritesUseCase(this.repository);

  Future<Either<Failure, Unit>> execute(CountryEntity country) {
    return repository.addToFavorites(country);
  }
}

/// Use case for removing a country from favorites
class RemoveFromFavoritesUseCase {
  final CountryRepository repository;

  RemoveFromFavoritesUseCase(this.repository);

  Future<Either<Failure, Unit>> execute(CountryEntity country) {
    return repository.removeFromFavorites(country);
  }
}

/// Use case for getting favorite countries
class GetFavoriteCountriesUseCase {
  final CountryRepository repository;

  GetFavoriteCountriesUseCase(this.repository);

  Future<Either<Failure, List<CountryEntity>>> execute() {
    return repository.getFavoriteCountries();
  }
}
