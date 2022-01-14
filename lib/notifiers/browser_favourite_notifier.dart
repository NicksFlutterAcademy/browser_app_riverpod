import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowserFavouriteNotifier extends StateNotifier<List<String>> {
  BrowserFavouriteNotifier() : super(<String>[]);

  void addToFavorites(String link) {
    List<String> favs = List.from(state, growable: true);
    favs.add(link);
    state = favs;
  }

  void removeFromFavorites(String link) {
    List<String> favs = List.from(state, growable: true);
    favs.remove(link);
    state = favs;
  }
}
