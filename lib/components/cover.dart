import 'package:flutter/material.dart';

class Cover extends StatelessWidget {
  final String? coverUrl;
  final Function()? onTap;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? placeHolderColor;
  final Icon? placeHolderIcon;
  final Color? loadingColor;
  final Color? failedColor;
  final IconData? failedIcon;
  final BoxFit? imageFit;

  Cover({this.coverUrl,
    this.onTap,
    this.placeHolderColor,
    this.loadingColor,
    this.placeHolderIcon,
    this.width,
    this.failedColor,
    this.failedIcon = Icons.image_not_supported,
    this.borderRadius = 0,
    this.imageFit, this.height});

  @override
  Widget build(BuildContext context) {
    var url = coverUrl;
    Widget renderNoEmptyView() {
      return InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            color: placeHolderColor,
            child: Center(
              child: placeHolderIcon,
            ),
          ),
        ),
        onTap: onTap,
      );
    }
    if (url != null) {
      return GestureDetector(
        child: ClipRRect(
          child: Image.network(
            url,
            fit: imageFit,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  color: failedColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                width: width,
                height: height,
                child: Center(
                  child: Icon(failedIcon),
                ),
              );
            },
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        onTap: onTap,
      );
    }
    return renderNoEmptyView();
  }
}
