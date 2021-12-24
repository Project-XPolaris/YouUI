import 'package:flutter/material.dart';
import 'package:youui/components/cover.dart';

class CoverTitleListItem extends StatelessWidget {
  final String? imageUrl;
  final double? coverWidth;
  final double? coverHeight;
  final Color? loadingCoverColor;
  final Color? placeholderColor;
  final Icon? placeHolderIcon;
  final EdgeInsets metaContainerMagin;
  final double metaHeight;
  final String title;
  final String? subtitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final BoxFit? imageBoxFit;
  final double borderRadius;
  final Function()? onTap;

  const CoverTitleListItem(
      {Key? key,
      this.metaHeight = 36,
      required this.title,
      this.subtitle,
      this.imageUrl,
      this.metaContainerMagin = const EdgeInsets.only(top: 8),
      this.coverWidth,
      this.loadingCoverColor,
      this.placeholderColor,
      this.placeHolderIcon,
      this.titleTextStyle,
      this.onTap,
      this.subtitleTextStyle,
      this.imageBoxFit,
      this.borderRadius = 0,
      this.coverHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? subtitle = this.subtitle;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        child: Row(
          children: [
            Cover(
              loadingColor: loadingCoverColor,
              placeHolderColor: placeholderColor,
              placeHolderIcon: placeHolderIcon,
              width: coverWidth,
              height: coverHeight,
              imageFit: imageBoxFit,
              coverUrl: imageUrl,
              borderRadius: borderRadius,
            ),
            Expanded(
              child: Container(
                margin: metaContainerMagin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleTextStyle,
                    ),
                    subtitle != null
                        ? Text(
                            subtitle,
                            style: subtitleTextStyle,
                          )
                        : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
