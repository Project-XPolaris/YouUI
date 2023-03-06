import 'package:flutter/material.dart';

class NavigationBarItem {
  final String label;
  final Icon icon;

  NavigationBarItem({required this.label, required this.icon});
}

class NavigationStyle {
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color? backgroundColor;

  NavigationStyle(
      {this.selectedItemColor, this.unselectedItemColor, this.backgroundColor});
}

class VerticalNavigationView extends StatelessWidget {
  final int tabIndex;
  final Function(int)? onTabIndexChange;
  final List<NavigationBarItem> navItems;
  final NavigationStyle? navigationStyle;
  final bool showBack;
  final Widget? action;

  const VerticalNavigationView(
      {Key? key,
      this.tabIndex = 0,
      this.onTabIndexChange,
      this.navItems = const [],
      this.showBack = false,
      this.action,
      this.navigationStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? actionWidget = action;
    List<NavigationRailDestination> items = navItems.map((e) {
      return NavigationRailDestination(icon: e.icon, label: Text(e.label));
    }).toList();
    if (showBack) {
      items.insert(
          0,
          const NavigationRailDestination(
              icon: Icon(Icons.arrow_back_sharp), label: Text("Back")));
    }
    _onTabIndexChange(int index) {
      if (showBack && index == 0) {
        Navigator.pop(context);
        return;
      }
      if (showBack) {
        onTabIndexChange?.call(index - 1);
      } else {
        onTabIndexChange?.call(index);
      }
    }

    _getTabIndex() {
      if (showBack) {
        return tabIndex + 1;
      }
      return tabIndex;
    }

    return NavigationRail(
      onDestinationSelected: _onTabIndexChange,
      selectedIndex: _getTabIndex(),
      destinations: items,
      trailing: actionWidget,
    );
  }
}

class HorizonNavigationView extends NavigationBar {
  final int tabIndex;
  final Function(int)? onTabIndexChange;
  final List<NavigationBarItem> navItems;
  final NavigationStyle? navigationStyle;

  HorizonNavigationView(
      {Key? key,
      this.tabIndex = 0,
      this.onTabIndexChange,
      this.navItems = const [],
      this.navigationStyle})
      : super(
          destinations: [
            ...navItems.map((e) {
              return NavigationDestination(icon: e.icon, label: e.label);
            })
          ],
          selectedIndex: tabIndex,
          onDestinationSelected: (int index) {
            onTabIndexChange?.call(index);
          },
        );
}
