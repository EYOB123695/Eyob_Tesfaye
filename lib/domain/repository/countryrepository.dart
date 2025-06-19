import 'package:dartz/dartz.dart';
import 'package:eyobtesfaye/domain/entities/countryentity.dart';

import '../../../../core/error/failure.dart';


abstract class CountryRepository {
  /// Fetch all countries from API
  Future<Either<Failure, List<CountryEntity>>> getAllCountries();

  /// Search countries by name
  Future<Either<Failure, List<CountryEntity>>> searchCountries(String query);

  /// Add country to favorites (persist locally)
  Future<Either<Failure, Unit>> addToFavorites(CountryEntity country);

  /// Remove country from favorites (locally)
  Future<Either<Failure, Unit>> removeFromFavorites(CountryEntity country);

  /// Get all favorited countries (from local storage)
  Future<Either<Failure, List<CountryEntity>>> getFavoriteCountries();
}
