import 'package:flutter/material.dart';

class FilterExample extends StatelessWidget {
  const FilterExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(onPressed: (){

          }, child: Text("Show Filter sheet"))
        ],
      ),
    );
  }
}

