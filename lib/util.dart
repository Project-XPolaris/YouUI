import 'package:flutter/material.dart';

Color getContrastTextColor(Color? color){
  if (color == null) {
    return Colors.white;
  }
  return color.computeLuminance() < 0.5 ? Colors.white : const Color(0x002a2a2a);
}