import 'package:flutter/material.dart';
import 'package:news/models/category.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewArticle extends StatefulWidget {
  static const String routeName = '/viewArticle-screen';
  final String articleUrl;

  const ViewArticle({Key? key, required this.articleUrl}) : super(key: key);

  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) {
                setState(() {
                  isLoading = false;
                });
              },
              onWebResourceError: (error) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.articleUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
