import 'package:flutter/material.dart';

class HomeTabLayoutVertical extends StatelessWidget {
  final AppBar? appbar;
  final NavigationBar? navigationBar;
  final Widget? body;
  const HomeTabLayoutVertical({Key? key, this.appbar,this.navigationBar,this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      bottomNavigationBar: navigationBar,
      body: body,
    );
  }
}
