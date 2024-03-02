import 'package:flutter/material.dart';

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
          child:Container()));
  }
}
