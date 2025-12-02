import 'package:flutter/material.dart';
import '../models/place.dart';
import '../data/favorites_store.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = '/details';
  final Place place;

  const DetailsScreen({super.key, required this.place});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final fav = isFavorite(widget.place);
    print('DetailsScreen: ${widget.place.name}, isFavorite=$fav');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.name),
        actions: [
          IconButton(
            icon: Icon(fav ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              toggleFavorite(widget.place);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    fav ? 'Removed from favorites.' : 'Added to favorites.',
                  ),
                  duration: const Duration(milliseconds: 900),
                ),
              );
            },
            tooltip: fav ? 'Unfavorite' : 'Favorite',
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.asset(
            widget.place.imageUrl,
            height: 240,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const SizedBox(
              height: 240,
              child: Center(child: Icon(Icons.image_not_supported)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.place, color: Colors.teal),
                    const SizedBox(width: 6),
                    Text(
                      widget.place.city,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(widget.place.rating.toStringAsFixed(1)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.place.description,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: Icon(fav ? Icons.remove : Icons.add),
                  label: Text(
                    fav ? 'Remove from favorites' : 'Add to favorites',
                  ),
                  onPressed: () {
                    toggleFavorite(widget.place);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.map),
                  label: const Text('Open on map (mock)'),
                  onPressed: () {
                    print('Map open simulated for ${widget.place.name}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Map opening simulated.'),
                        duration: Duration(milliseconds: 900),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
