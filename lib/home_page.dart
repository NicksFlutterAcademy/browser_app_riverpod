import 'package:browser_app_riverpod/providers.dart';
import 'package:browser_app_riverpod/widgets/fav_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containsFav = ref.watch(containsFavProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              final String currentUrl = ref.read(currentUrlProvider);

              if (containsFav) {
                ref
                    .read(browserFavouriteProvider.notifier)
                    .removeFromFavorites(currentUrl);
              } else {
                ref
                    .read(browserFavouriteProvider.notifier)
                    .addToFavorites(currentUrl);
              }
            },
            child: Text(containsFav ? "Remove from favs" : "Add to favs"),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autocorrect: false,
                    controller: ref.read(textEditingControllerProvider),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final textEditingController =
                        ref.read(textEditingControllerProvider);

                    FocusScope.of(context).unfocus();

                    ref
                        .read(controllerProvider.notifier)
                        .goToPage(url: textEditingController.text);

                    textEditingController.clear();
                  },
                  icon: const Icon(Icons.arrow_forward_ios, size: 30),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          if (ref.watch(favsCountProvider) != 0) const FavsHorizontalList(),
          Expanded(
            child: WebView(
              onWebViewCreated: (webViewController) {
                ref
                    .read(controllerProvider.notifier)
                    .setController(webViewController);
              },
              initialUrl: ref.read(currentUrlProvider),
              onWebResourceError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error, can not go to ${error.failingUrl}"),
                  ),
                );
              },
              onPageStarted: (link) =>
                  ref.read(currentUrlProvider.notifier).setLink(link),
            ),
          ),
        ],
      ),
    );
  }
}
