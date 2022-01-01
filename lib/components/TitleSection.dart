import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final TextStyle? titleTextStyle;
  final Widget child;
  TitleSection({Key? key, required this.title, this.titleTextStyle,required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Text(
                title,
                style: titleTextStyle,
              )),
          child,
        ],
      ),
    );
  }
}
