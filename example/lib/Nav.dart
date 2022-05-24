import 'package:flutter/material.dart';
import 'package:youui/components/navigation.dart';

class NavExpanlePage extends StatefulWidget {
  const NavExpanlePage({Key? key}) : super(key: key);

  @override
  State<NavExpanlePage> createState() => _NavExpanlePageState();
}

class _NavExpanlePageState extends State<NavExpanlePage> {
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HorizonNavigationView(
        onTabIndexChange: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        navItems: [
          NavigationBarItem(label: "item1", icon: Icon(Icons.home)),
          NavigationBarItem(label: "item2", icon: Icon(Icons.usb)),
          NavigationBarItem(label: "item2", icon: Icon(Icons.cabin)),
          NavigationBarItem(label: "item2", icon: Icon(Icons.dangerous))
        ],
        navigationStyle: NavigationStyle(
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
        ),
        tabIndex: selectIndex,
      ),
      body: Row(
        children: [
          VerticalNavigationView(
            onTabIndexChange: (index) {
              setState(() {
                selectIndex = index;
              });
            },
            navItems: [
              NavigationBarItem(label: "item1", icon: Icon(Icons.home)),
              NavigationBarItem(label: "item2", icon: Icon(Icons.usb)),
              NavigationBarItem(label: "item2", icon: Icon(Icons.cabin)),
              NavigationBarItem(label: "item2", icon: Icon(Icons.dangerous))
            ],
            navigationStyle: NavigationStyle(
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).colorScheme.secondary,
            ),
            tabIndex: selectIndex,
          )

        ],
      ),
    );
    return Scaffold(
      body: Center(
        child: Text("hello"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "item1"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "item2"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "item3"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "item4"),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
