import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-list-item.dart';

class CoverTitleListItemExample extends StatelessWidget {
  const CoverTitleListItemExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CoverTitleExample"),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            ...List.generate(100, (index) {
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                child: CoverTitleListItem(
                  title: "item ${index}",
                  subtitle: "subtitle ${index}",
                  metaContainerMagin: EdgeInsets.only(left: 16),
                  imageUrl:
                      "https://images.freeimages.com/images/large-previews/76e/abstract-1-1174741.jpg",
                  titleTextStyle: TextStyle(color: Colors.white),
                  subtitleTextStyle: TextStyle(color: Colors.white),
                  loadingCoverColor: Colors.green,
                  placeholderColor: Colors.red,
                  coverHeight: 120,
                  coverWidth: 120 * 4 / 3,
                  borderRadius: 6,
                  imageBoxFit: BoxFit.contain,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
