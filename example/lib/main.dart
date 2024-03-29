import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:youui/layout/login/LoginLayout.dart';
import 'package:youui/layout/login/NewAccountLayout.dart';
import 'package:youui/youui.dart';
import 'package:youui_example/Nav.dart';
import 'package:youui_example/cover-title-item-example.dart';
import 'package:youui_example/cover-title-list-item-example.dart';
import 'package:youui_example/horizon-list-example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await Youui.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed:Colors.greenAccent ,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed:Colors.greenAccent ,
      ),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(
          builder: (context) {
            return Center(
                child: ListView(
              children: [
                ListTile(
                  title: const Text("CoverTitleGridItem"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CoverTitleItemExample()),
                    );
                  },
                ),
                ListTile(
                  title: const Text("CoverTitleListItem"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CoverTitleListItemExample()),
                    );
                  },
                ),
                ListTile(
                  title: const Text("HorizonList"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HorizonListExample()),
                    );
                  },
                ),
                ListTile(
                  title: const Text("NewLogin"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewLoginLayout(onLogin: (history){})),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Auth"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginLayout(
                            title: 'My app',
                            onLoginSuccess: (LoginHistory ) {

                            },
                            subtitle: 'from someone',
                          )),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Horizon Naviagtion"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavExpanlePage())
                    );
                  },
                ),
              ],
            ));
          }
        ),
      ),
    );
  }
}
