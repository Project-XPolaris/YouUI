import 'package:flutter/material.dart';

import 'cover.dart';

class ItemViewHorizon extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final Function()? onMore;
  final TextStyle? moreButtonTextStyle;
  final TextStyle? titleStyle;

  ItemViewHorizon(
      {required this.children,
      required this.title,
      this.onMore,
      this.moreButtonTextStyle,
      this.titleStyle = const TextStyle(fontWeight: FontWeight.w600)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: titleStyle),
                onMore != null
                    ? GestureDetector(
                        child: Text(
                          "more",
                          style: moreButtonTextStyle,
                        ),
                        onTap: onMore,
                      )
                    : Container()
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [...children],
            ),
          )
        ],
      ),
    );
  }
}

class HorizonItem extends StatelessWidget {
  final String? coverUrl;
  final String name;
  final Function()? onTap;
  final double coverWidth;
  final double coverHeight;
  final double maxCoverWidth;
  final double maxCoverHeight;

  final EdgeInsets padding;

  HorizonItem(
      {this.coverUrl,
      this.name = "Unknown",
      this.onTap,
      this.padding = const EdgeInsets.all(0),
      this.coverWidth = 240,
      this.coverHeight = 120,
      this.maxCoverHeight = 240,
      this.maxCoverWidth = 240});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: coverWidth,
        height: coverHeight + 32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Center(
                child: Cover(
                  coverUrl: coverUrl,
                  width: coverWidth,
                  onTap: onTap,
                ),
              ),
              width: maxCoverWidth,
              height: maxCoverHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
