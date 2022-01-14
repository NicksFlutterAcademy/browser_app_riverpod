import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentUrlNotifier extends StateNotifier<String> {
  CurrentUrlNotifier() : super("https://google.com");

  void setLink(String link) {
    state = link;
  }
}
