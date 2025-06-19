import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:eyobtesfaye/core/constants/api_const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import 'package:eyobtesfaye/core/error/failure.dart';
import 'package:eyobtesfaye/data/model/countrymodel.dart';
import 'package:eyobtesfaye/domain/entities/countryentity.dart';
import 'package:eyobtesfaye/domain/repository/countryrepository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final http.Client client;

  CountryRepositoryImpl({required this.client});

  static const _favoritesKey = 'FAVORITE_COUNTRIES';

  @override
  Future<Either<Failure, List<CountryEntity>>> getAllCountries() async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/independent?status=true&fields=name,flags,area,region,subregion,population,timezones',
    );

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        final countries = data.map((e) => CountryModel.fromJson(e).toEntity()).toList();
        return Right(countries);
      } else {
        return Left(ServerFailure('Failed to fetch countries'));
      }
    } catch (e) {
      return Left(ServerFailure('Network error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<CountryEntity>>> searchCountries(String query) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/name/$query?fields=name,flags,area,region,subregion,population,timezones',
    );

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        final countries = data.map((e) => CountryModel.fromJson(e).toEntity()).toList();
        return Right(countries);
      } else if (response.statusCode == 404) {
        return Right([]); // No results found
      } else {
        return Left(ServerFailure('Failed to search countries'));
      }
    } catch (e) {
      return Left(ServerFailure('Search error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addToFavorites(CountryEntity country) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favList = prefs.getStringList(_favoritesKey) ?? [];
      favList.add(json.encode(CountryModel.fromEntity(country).toJson()));
      await prefs.setStringList(_favoritesKey, favList);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to save favorite: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromFavorites(CountryEntity country) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favList = prefs.getStringList(_favoritesKey) ?? [];

      favList.removeWhere((item) {
        final model = CountryModel.fromJson(json.decode(item));
        return model.name.common == country.name;
      });

      await prefs.setStringList(_favoritesKey, favList);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to remove favorite: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<CountryEntity>>> getFavoriteCountries() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favList = prefs.getStringList(_favoritesKey) ?? [];

      final countries = favList
          .map((e) => CountryModel.fromJson(json.decode(e)).toEntity())
          .toList();

      return Right(countries);
    } catch (e) {
      return Left(CacheFailure('Failed to load favorites: ${e.toString()}'));
    }
  }
}
