import 'package:flutter/material.dart';
import 'package:youui/components/cover.dart';

class CoverTitleGridItem extends StatelessWidget {
  final String? imageUrl;
  final double? coverWidth;
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
  final double? coverHeight;
  final Color? failedColor;
  final IconData? failedIcon;
  final Alignment? imageAlignment;
  final int titleMaxLine;
  final int subtitleMaxLine;
  final Function()? onTitleTap;

  const CoverTitleGridItem({Key? key,
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
    this.failedColor,
    this.failedIcon,
    this.imageAlignment,
    this.subtitleTextStyle,
    this.imageBoxFit,
    this.borderRadius = 0,
    this.subtitleMaxLine = 1,
    this.titleMaxLine = 1,
    this.onTitleTap,
    this.coverHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? subtitle = this.subtitle;
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: imageAlignment,
              child: Cover(
                loadingColor: loadingCoverColor,
                placeHolderColor: placeholderColor,
                placeHolderIcon: placeHolderIcon,
                imageFit: imageBoxFit,
                coverUrl: imageUrl,
                borderRadius: borderRadius,
                failedColor: failedColor,
                failedIcon: failedIcon,
              ),
            ),
          ),
        ),
        Container(
          margin: metaContainerMagin,
          height: metaHeight,
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              if (onTitleTap != null) {
                this.onTitleTap!();
                return;
              }
              if (onTap != null){
                this.onTap!();
                return;
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: titleMaxLine,
                  style: titleTextStyle,
                  textAlign: TextAlign.center,
                ),
                subtitle != null
                    ? Text(
                  subtitle,
                  maxLines: titleMaxLine,
                  style: subtitleTextStyle,
                  textAlign: TextAlign.center,
                )
                    : Container()
              ],
            ),
          ),
        )
      ],
    );
  }
}
