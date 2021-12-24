import 'package:cached_network_image/cached_network_image.dart';
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
  final BoxFit? imageFit;

  Cover(
      {this.coverUrl,
      this.onTap,
      this.placeHolderColor,
      this.loadingColor,
      this.placeHolderIcon,
      this.width,
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
          child: CachedNetworkImage(
            fit: imageFit,
            imageUrl: url,
            width: width,
            height: height,
            placeholder: (context, url) => Container(
              color: loadingColor,
            ),
            errorWidget: (context, url, error) => renderNoEmptyView(),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        onTap: onTap,
      );
    }
    return renderNoEmptyView();
  }
}
