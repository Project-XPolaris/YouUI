import 'package:flutter/material.dart';

class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final int itemWidth;
  final double aspectRatio;
  final ScrollPhysics? physics;

  const ResponsiveGridView({Key? key,
    this.aspectRatio = 1,
    required this.children,
    required this.itemWidth,
    this.physics,
    this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var crossAxisCount = constraints.maxWidth ~/ itemWidth;
          return GridView.count(
            controller: controller,
            physics: physics,
            primary: false,
            childAspectRatio: aspectRatio,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: crossAxisCount,
            children: children,
          );
        }
    );
  }
}
