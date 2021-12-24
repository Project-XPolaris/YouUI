import 'package:flutter/material.dart';

class HomeTabLayoutVertical extends StatelessWidget {
  final AppBar? appbar;
  final BottomNavigationBar? bottomNavigationBar;
  final Widget? body;
  const HomeTabLayoutVertical({Key? key, this.appbar,this.bottomNavigationBar,this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      bottomNavigationBar: bottomNavigationBar,
      body: body,
    );
  }
}
