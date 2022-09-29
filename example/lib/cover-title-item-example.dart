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
        aspectRatio: 4 /3,
        children: [
          ...List.generate(100, (index) {
            return CoverTitleGridItem(
              title: "item ${index}",
              imageUrl:  getRandomHeight(),
              borderRadius: 6,
              imageBoxFit: BoxFit.contain,
              imageAlignment: Alignment.bottomCenter,
            );
          })
        ],
      ),
    );
  }
}
