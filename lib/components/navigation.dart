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

  const VerticalNavigationView({Key? key,
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
      return NavigationRailDestination(
          icon: e.icon, label: Text(e.label));
    }).toList();
    if (showBack) {
      items.insert(0,const NavigationRailDestination(icon: Icon(Icons.arrow_back_sharp), label: Text("Back")));
    }
    _onTabIndexChange(int index) {
      if (showBack && index == 0) {
        Navigator.pop(context);
        return;
      }
      if (showBack) {
        onTabIndexChange?.call(index - 1);
      }else{
        onTabIndexChange?.call(index);
      }
    }
    _getTabIndex(){
      if (showBack) {
        return tabIndex + 1;
      }
      return tabIndex;
    }
    return Container(
      color: navigationStyle?.backgroundColor,
      child: Column(children: [
        Container(height: 24,),
        Expanded(
            child: NavigationRail(
                selectedIconTheme: IconThemeData(
                  color: navigationStyle?.selectedItemColor,
                ),
                unselectedIconTheme:
                IconThemeData(color: navigationStyle?.unselectedItemColor),
                backgroundColor: navigationStyle?.backgroundColor,
                onDestinationSelected: _onTabIndexChange,
                selectedIndex: _getTabIndex(),
                destinations:items)),
        actionWidget ?? Container(),
      ]),
    );
  }
}

class HorizonNavigationView extends BottomNavigationBar {
  final int tabIndex;
  final Function(int)? onTabIndexChange;
  final List<NavigationBarItem> navItems;
  final NavigationStyle? navigationStyle;

  HorizonNavigationView({Key? key,
    this.tabIndex = 0,
    this.onTabIndexChange,
    this.navItems = const [],
    this.navigationStyle})
      : super(
      key: key,
      onTap: onTabIndexChange,
      currentIndex: tabIndex,
      selectedItemColor: navigationStyle?.selectedItemColor,
      unselectedItemColor: navigationStyle?.unselectedItemColor,
      backgroundColor: navigationStyle?.backgroundColor,
      elevation: 0,
      items: navItems.map((e) {
        return BottomNavigationBarItem(icon: e.icon, label: e.label);
      }).toList());
}