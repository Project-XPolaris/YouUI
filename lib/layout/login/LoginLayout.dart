import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youplusauthplugin/youplusauthplugin.dart';
import 'package:youui/account/store.dart';

class LoginLayout extends StatefulWidget {
  final String? defaultPort;
  final Function(LoginHistory) onLoginSuccess;
  final String title;
  final Color? titleColor;
  final String subtitle;
  final Color? subtitleColor;
  final Color? backgroundColor;
  final Color? mainColor;

  const LoginLayout(
      {Key? key,
      this.defaultPort,
      this.mainColor,
      this.titleColor,
      this.subtitleColor,
      this.backgroundColor,
      required this.onLoginSuccess,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  _LoginLayoutState createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  Youplusauthplugin plugin = Youplusauthplugin();
  String inputUrl = "";
  String inputUsername = "";
  String inputPassword = "";
  String loginMode = "history";

  @override
  Widget build(BuildContext context) {
    bool showYouPlusLogin = Platform.isAndroid;
    String? _getInputUrl() {
      if (inputUrl.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("please input service url")));
        return null;
      }
      Uri uri;
      try {
        uri = Uri.parse(inputUrl);
      } on FormatException catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("input service url invalidate")));
        return null;
      }
      final String? defaultPort = widget.defaultPort;
      if (!uri.hasScheme) {
        inputUrl = "http://" + inputUrl;
      }
      if (!uri.hasPort && defaultPort != null) {
        inputUrl += ":$defaultPort";
      }
      return inputUrl;
    }

    Future<bool> _init() async {
      await AccountManager().init(authCallback: (loginHistory) {
        widget.onLoginSuccess.call(loginHistory);
      });
      return true;
    }

    _onFinishClick() async {
      final String? serviceUrl = _getInputUrl();
      if (serviceUrl == null) {
        return;
      }
      LoginHistory? loginAccount = await AccountManager()
          .login(serviceUrl, inputUsername, inputPassword);
      if (loginAccount == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("login error")));
        return;
      }
      widget.onLoginSuccess.call(loginAccount);
    }

    _onHistoryClick(LoginHistory loginHistory) async {
      await AccountManager().loginWithHistory(loginHistory);
      widget.onLoginSuccess.call(loginHistory);
    }

    _onOpenYouPlusClick() {
      final url = _getInputUrl();
      if (url == null) {
        return;
      }
      AccountManager().openYouPlus(url);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.backgroundColor,
      ),
      body: FutureBuilder(
        future: _init(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              color: widget.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.titleColor,
                        fontSize: 42,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                          color: widget.subtitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w200),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                        child: DefaultTabController(
                      initialIndex: LoginHistoryManager().list.isEmpty ? 1 : 0,
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 240,
                            margin: const EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                            ),
                            child: const TabBar(
                              tabs: [
                                Tab(
                                  text: "History",
                                ),
                                Tab(
                                  text: "New login",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: TabBarView(
                            children: [
                              ListView(
                                children:
                                    AccountManager().loginHistoryManager.list.map((history) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      onTap: () => _onHistoryClick(history),
                                      leading: const CircleAvatar(
                                        child: Icon(Icons.person),
                                      ),
                                      title: Text(history.username!),
                                      subtitle: Text(history.apiUrl!),
                                      tileColor: Colors.black26,
                                    ),
                                  );
                                }).toList(),
                              ),
                              ListView(
                                children: [
                                  LoginInput(
                                    activeColor: widget.mainColor,
                                    unactiveColor: Colors.white24,
                                    onInputChange: (text) {
                                      setState(() {
                                        inputUrl = text;
                                      });
                                    },
                                    hintText: 'Service url',
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: LoginInput(
                                      activeColor: widget.mainColor,
                                      unactiveColor: Colors.white24,
                                      onInputChange: (text) {
                                        setState(() {
                                          inputUsername = text;
                                        });
                                      },
                                      hintText: 'Username',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: LoginInput(
                                      activeColor: widget.mainColor,
                                      unactiveColor: Colors.white24,
                                      onInputChange: (text) {
                                        setState(() {
                                          inputPassword = text;
                                        });
                                      },
                                      obscureText: true,
                                      hintText: 'Password',
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(top: 16),
                                    child: ElevatedButton(
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(),
                                      ),
                                      onPressed: () {
                                        _onFinishClick();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: widget.mainColor,
                                      ),
                                    ),
                                  ),
                                  showYouPlusLogin
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: TextButton(
                                            child: Text(
                                              "Login with YouPlus",
                                              style: TextStyle(
                                                  color: widget.mainColor),
                                            ),
                                            onPressed: _onOpenYouPlusClick,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class LoginInput extends StatelessWidget {
  final Function(String)? onInputChange;
  final String? hintText;
  final Color? activeColor;
  final Color unactiveColor;
  final bool obscureText;

  const LoginInput(
      {Key? key,
      this.onInputChange,
      this.hintText,
      this.activeColor,
      this.unactiveColor = Colors.white24,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: activeColor ?? Theme.of(context).primaryColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: unactiveColor, width: 1.0),
        ),
        hintText: hintText,
      ),
      cursorColor: activeColor ?? Theme.of(context).primaryColor,
      onChanged: onInputChange,
      obscureText: obscureText,
    );
  }
}