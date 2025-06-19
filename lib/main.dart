import 'package:eyobtesfaye/data/repository/countryrepositoryimpl.dart';
import 'package:eyobtesfaye/domain/usecase/usecases.dart';
import 'package:eyobtesfaye/presentation/bloc/country_bloc.dart';
import 'package:eyobtesfaye/presentation/bloc/country_event.dart';
import 'package:eyobtesfaye/presentation/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final client = http.Client();
    final repository = CountryRepositoryImpl(client: client);
    final getAllCountriesUseCase = GetAllCountriesUseCase(repository);
    final searchCountriesUseCase = SearchCountriesUseCase(repository);
    final addToFavoritesUseCase = AddToFavoritesUseCase(repository);
    final removeFromFavoritesUseCase = RemoveFromFavoritesUseCase(repository);

    return MultiBlocProvider(
      providers: [
        BlocProvider<CountryBloc>(
          create: (_) => CountryBloc(
            getAllCountries: getAllCountriesUseCase,
            searchCountries: searchCountriesUseCase,
            addToFavorites: addToFavoritesUseCase,
            removeFromFavorites: removeFromFavoritesUseCase,
          )..add(FetchCountries()),
        ),
      ],
      child: MaterialApp(
        title: 'Country App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CountryScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
