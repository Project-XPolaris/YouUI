import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';
import 'package:youui/components/gridview.dart';

class CoverTitleItemExample extends StatelessWidget {
  const CoverTitleItemExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CoverTitleExample"),
      ),
      body: Container(
        color: Colors.black,
        child: ResponsiveGridView(
          itemWidth: 200,
          aspectRatio: 4 /3,
          children: [
            ...List.generate(100, (index) {
              return Center(
                child: SizedBox(
                  width: 200,
                  child: CoverTitleGridItem(
                    title: "item ${index}",
                    imageUrl:  "https://images.freeimages.com/images/large-previews/76e/abstract-1-1174741.jpg",
                    titleTextStyle: TextStyle(color: Colors.white),
                    loadingCoverColor: Colors.green,
                    placeholderColor: Colors.red,
                    coverWidth: 200,
                    borderRadius: 6,
                    imageBoxFit: BoxFit.contain,
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
