import 'package:flutter/material.dart';
import 'package:youui/components/navigation.dart';
import 'package:youui/components/viewport-selector.dart';
import 'package:youui/layout/home/home-horizon.dart';

import 'home-vertical.dart';



class ResponsiveTabPageLayout extends StatelessWidget {
  final int tabIndex;
  final Function(int)? onTabIndexChange;
  final List<NavigationBarItem> navItems;
  final NavigationStyle? navigationStyle;
  final Widget? body;
  final AppBar? appbar;
  final Widget? action;
  const ResponsiveTabPageLayout({
    this.navigationStyle,
    this.navItems = const [],
    Key? key,
    this.tabIndex = 0,
    this.body,
    this.appbar,
    this.action,
    required this.onTabIndexChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewportSelector(
      verticalChild: HomeTabLayoutVertical(
        body: body,
        appbar: appbar,
        navigationBar: HorizonNavigationView(
            onTabIndexChange: onTabIndexChange,
            tabIndex: tabIndex,
            navigationStyle: navigationStyle,
            navItems: navItems,
        ),
      ),
      horizonChild: Scaffold(
        body: HomeTabLayoutHorizon(
          body: body,
          verticalNavigation: VerticalNavigationView(
            action: action,
            onTabIndexChange: onTabIndexChange,
            tabIndex: tabIndex,
            navigationStyle: navigationStyle,
            navItems: navItems,
          ),
        ),
      ),
    );
  }
}
