import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  final Map<String, dynamic> country;
  final VoidCallback onFavoritePressed;
  final bool isFavorite;

  const CountryCard({
    Key? key,
    required this.country,
    required this.onFavoritePressed,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countryName = country['name']['common'] ?? 'Unknown';
    final population = country['population']?.toString() ?? 'N/A';
    final flagUrl = country['flag'];

    return Card(
      color: Colors.white,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            /// Column 1: Flag image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                flagUrl,
                width: 60,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 40,
                  color: Colors.grey,
                  child: const Icon(Icons.flag, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(width: 16),

            /// Column 2: Country name and population
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    countryName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Population: $population',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            /// Column 3: Favorite icon
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: onFavoritePressed,
            ),
          ],
        ),
      ),
    );
  }
}
