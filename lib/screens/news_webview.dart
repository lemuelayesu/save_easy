import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebview extends StatefulWidget {
  const NewsWebview({super.key, required this.url});

  final String url;

  @override
  State<NewsWebview> createState() => _NewsWebviewState();
}

class _NewsWebviewState extends State<NewsWebview> {
  late final PlatformWebViewControllerCreationParams params;

  @override
  void initState() {
    super.initState();
    params = const PlatformWebViewControllerCreationParams();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: WebViewWidget(
          controller: WebViewController.fromPlatformCreationParams(params)
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(Colors.white)
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {},
                onWebResourceError: (WebResourceError error) {
                  log('Error: ${error.description}');
                  log('URL: ${widget.url}');
                },
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(
              Uri.parse(widget.url),
            ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          height: 100,
          decoration: BoxDecoration(
            color: color.primary,
          ),
          child: const Text(
            'Back To App',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
