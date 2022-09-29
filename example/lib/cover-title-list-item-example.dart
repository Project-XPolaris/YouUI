import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-list-item.dart';
import 'package:youui_example/utils.dart';

class CoverTitleListItemExample extends StatelessWidget {
  const CoverTitleListItemExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CoverTitleExample"),
      ),
      body: Container(
        child: ListView(
          children: [
            ...List.generate(100, (index) {
              var image = getRandomWidthHeightImage();
              var imageWidth = image[0];
              var imageHeight = image[1];
              var width = 120.0;
              var height = width * imageHeight / imageWidth;
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                child: CoverTitleListItem(
                  title: "item ${index}",
                  subtitle: "subtitle ${index}",
                  metaContainerMagin: EdgeInsets.only(left: 16),
                  imageUrl: image[2],
                  coverHeight: height,
                  coverWidth: width,
                  borderRadius: 8,
                  imageBoxFit: BoxFit.cover,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
