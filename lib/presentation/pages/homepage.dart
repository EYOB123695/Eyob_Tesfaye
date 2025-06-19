import 'package:eyobtesfaye/presentation/bloc/country_bloc.dart';
import 'package:eyobtesfaye/presentation/bloc/country_event.dart';
import 'package:eyobtesfaye/presentation/bloc/country_state.dart';
import 'package:eyobtesfaye/presentation/widgets/countrycard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CountryBloc>(context).add(FetchCountries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const Center(
              child: Text(
                'Countries',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search for a country',
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      ),
                      onChanged: (value) {
                        setState(() => searchQuery = value);
                        BlocProvider.of<CountryBloc>(context)
                            .add(SearchCountries(value));
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<CountryBloc, CountryState>(
                builder: (context, state) {
                  if (state is CountryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CountryLoaded) {
                    final countries = state.filteredCountries;
                    final favorites = state.favoriteCountryNames;

                    if (countries.isEmpty) {
                      return const Center(child: Text("No countries found"));
                    }

                    return ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        final isFavorite = favorites.contains(country.name);

                        final countryMap = {
                          "name": {"common": country.name},
                          "flag": country.flag,
                          "population": country.population,
                        };

                        return CountryCard(
                          country: countryMap,
                          isFavorite: isFavorite,
                          onFavoritePressed: () {
                            BlocProvider.of<CountryBloc>(context)
                                .add(ToggleFavoriteCountry(country.name));
                          },
                        );
                      },
                    );
                  } else if (state is CountryError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is CountryEmptyResult) {
                    return const Center(child: Text("No countries found"));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home, size: 30),
                        SizedBox(height: 4),
                        Text('Home'),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite_border, size: 30),
                      SizedBox(height: 4),
                      Text('Favourites'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
