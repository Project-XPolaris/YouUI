import 'package:flutter/material.dart';

class HomeTabLayoutHorizon extends StatelessWidget {
  final Widget? verticalNavigation;
  final Widget? body;

  const HomeTabLayoutHorizon({Key? key, this.verticalNavigation, this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16),
              child: verticalNavigation
          ),
          Expanded(
              child: Container(
                child: body,
              ))
        ],
      ),
    );
  }
}
