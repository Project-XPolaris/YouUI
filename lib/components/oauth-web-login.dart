import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebOauthWindow extends StatelessWidget {
  final String oauthUrl;

  const WebOauthWindow({Key? key, required this.oauthUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(oauthUrl)),
            onLoadStop: (controller, url) {
              final code = url?.queryParameters["code"];
              if (code != null) {
                Navigator.of(context).pop(code);
              }
            },
          ),
        ));
  }
}
