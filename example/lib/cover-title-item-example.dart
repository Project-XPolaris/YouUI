import 'dart:math';

import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';
import 'package:youui/components/gridview.dart';
import 'package:youui_example/utils.dart';

class CoverTitleItemExample extends StatelessWidget {
  const CoverTitleItemExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CoverTitleExample"),
      ),
      body: ResponsiveGridView(
        itemWidth: 200,
        aspectRatio: 0.5,
        children: [
          ...List.generate(100, (index) {
            return CoverTitleGridItem(
              title: "item ${index} longggg longggg longggg longgg longggg longggg longggg longgg",
              imageUrl:  "https://picsum.photos/id/1/200/300",
              borderRadius: 6,
              imageBoxFit: BoxFit.contain,
              imageAlignment: Alignment.bottomCenter,
              metaHeight: 64,
            );
          })
        ],
      ),
    );
  }
}
