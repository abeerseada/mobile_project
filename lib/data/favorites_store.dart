import '../models/place.dart';
import 'mock_places.dart';

final Set<int> _favoriteIds = {};

bool isFavorite(Place place) => _favoriteIds.contains(place.id);

void toggleFavorite(Place place) {
  if (isFavorite(place)) {
    _favoriteIds.remove(place.id);
    print('Removed from favorites: ${place.name}');
  } else {
    _favoriteIds.add(place.id);
    print('Added to favorites: ${place.name}');
  }
}

List<Place> getFavoritePlaces() {
  return mockPlaces.where((p) => _favoriteIds.contains(p.id)).toList();
}

int favoritesCount() => _favoriteIds.length;
