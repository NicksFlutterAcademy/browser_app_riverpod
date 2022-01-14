import 'package:browser_app_riverpod/notifiers/browser_favourite_notifier.dart';
import 'package:browser_app_riverpod/notifiers/controller_notifier.dart';
import 'package:browser_app_riverpod/notifiers/current_url_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

final controllerProvider =
    StateNotifierProvider<WebViewControllerNotifier, WebViewController?>((ref) {
  return WebViewControllerNotifier();
});

final textEditingControllerProvider =
    Provider<TextEditingController>((ref) => TextEditingController());

final currentUrlProvider = StateNotifierProvider<CurrentUrlNotifier, String>(
    (ref) => CurrentUrlNotifier());

final browserFavouriteProvider =
    StateNotifierProvider<BrowserFavouriteNotifier, List<String>>((ref) {
  return BrowserFavouriteNotifier();
});

final favsCountProvider =
    Provider<int>((ref) => ref.watch(browserFavouriteProvider).length);

final containsFavProvider = Provider<bool>((ref) {
  final String currentUrl = ref.watch(currentUrlProvider);
  final List<String> browserFavourites = ref.watch(browserFavouriteProvider);

  if (!browserFavourites.contains(currentUrl)) {
    return false;
  } else {
    return true;
  }
});
