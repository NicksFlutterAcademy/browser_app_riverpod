import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewControllerNotifier extends StateNotifier<WebViewController?> {
  WebViewControllerNotifier() : super(null);

  void setController(WebViewController webViewController) {
    state = webViewController;
  }

  void goToPage({required String url}) {
    if (url == "") {
      return;
    }

    if (!url.startsWith("https://") && !url.startsWith("http://")) {
      url = "https://$url";
    }

    state?.loadUrl(url);
  }
}
