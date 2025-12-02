import 'package:flutter/material.dart';
import '../data/favorites_store.dart';
import '../models/place.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  static const String routeName = '/favorites';
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favs = getFavoritePlaces();
    print('FavoritesScreen: count=${favs.length}');

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favs.isEmpty
          ? const Center(
              child: Text(
                'No favorites yet.\nAdd some from the details page.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.separated(
              itemCount: favs.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, index) {
                final place = favs[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(place.imageUrl),
                    onBackgroundImageError: (_, __) {},
                  ),
                  title: Text(place.name),
                  subtitle: Text(place.city),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments: place,
                  ).then((_) => setState(() {})),
                );
              },
            ),
    );
  }
}
