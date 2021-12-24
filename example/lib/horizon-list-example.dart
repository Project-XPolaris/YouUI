import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';
import 'package:youui/components/itemview-horizon.dart';

class HorizonListExample extends StatelessWidget {
  const HorizonListExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CoverTitleExample"),
      ),
      body: Container(
        color: Colors.black,
        child: Container(
          child: ListView(
            children: [
              Container(
                height: 200,
                child: ItemViewHorizon(
                  children: [
                    ...List.generate(100, (index) {
                      return Container(
                        height: 200,
                        width: 200,
                        margin: EdgeInsets.only(right: 16),
                        child: CoverTitleGridItem(
                          title: "item ${index}",
                          imageUrl:
                              "https://images.freeimages.com/images/large-previews/76e/abstract-1-1174741.jpg",
                          titleTextStyle: TextStyle(color: Colors.white),
                          loadingCoverColor: Colors.green,
                          placeholderColor: Colors.red,
                          coverWidth: 200,
                          borderRadius: 6,
                          imageBoxFit: BoxFit.contain,
                        ),
                      );
                    })
                  ],
                  title: "title",
                  titleStyle: TextStyle(color: Colors.white),
                  onMore: (){

                  },
                  moreButtonTextStyle: TextStyle(
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
