import 'package:flutter/material.dart';

class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final int itemWidth;
  final double aspectRatio;

  const ResponsiveGridView({Key? key,
    this.aspectRatio = 1,
    required this.children,
    required this.itemWidth,
    this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var crossAxisCount = width ~/ itemWidth;
    return GridView.count(
      controller: controller,
      primary: false,
      childAspectRatio:aspectRatio,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: crossAxisCount,
      children: children,
    );
  }
}
