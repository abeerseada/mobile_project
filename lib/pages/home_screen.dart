import 'package:flutter/material.dart';
import '../data/mock_places.dart';
import '../models/place.dart';
import 'details_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';

  List<Place> get _filtered {
    if (_query.isEmpty) return mockPlaces;
    final q = _query.toLowerCase();
    return mockPlaces.where((p) {
      return p.name.toLowerCase().contains(q) ||
          p.city.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print('HomeScreen: building with ${_filtered.length} places');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Egypt'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favorites',
            onPressed: () =>
                Navigator.pushNamed(context, FavoritesScreen.routeName),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () =>
                Navigator.pushNamed(context, SettingsScreen.routeName),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by name or city...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.78,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final place = _filtered[index];
                return _PlaceCard(place: place);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final Place place;
  const _PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: place,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.asset(
                place.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const ColoredBox(
                  color: Colors.grey,
                  child: Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                place.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.place, size: 16, color: Colors.teal),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      place.city,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  Text(place.rating.toStringAsFixed(1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
