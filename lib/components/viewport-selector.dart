import 'package:flutter/material.dart';

class ViewportSelector extends StatelessWidget {
  final Widget verticalChild;
  final Widget? horizonChild;
  final int breakpoint;
  const ViewportSelector({Key? key,required this.verticalChild,this.horizonChild,this.breakpoint = 600}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isWide = MediaQuery.of(context).size.width > breakpoint;
    if (isWide) {
      return horizonChild ?? verticalChild;
    }
    return verticalChild;
  }
}
