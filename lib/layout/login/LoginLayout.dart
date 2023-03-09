import 'package:flutter/material.dart';
import 'package:youui/account/info.dart';
import 'package:youui/account/store.dart';
import 'package:youui/layout/login/NewAccountLayout.dart';

class LoginLayout extends StatefulWidget {
  final Function(LoginHistory) onLoginSuccess;
  final String title;
  final String subtitle;

  const LoginLayout({Key? key,
    required this.onLoginSuccess,
    required this.title,
    required this.subtitle})
      : super(key: key);

  @override
  _LoginLayoutState createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  String inputUrl = "";
  String inputUsername = "";
  String inputPassword = "";
  String loginMode = "history";
  Info? serviceInfo;

  @override
  Widget build(BuildContext context) {
    Future<bool> _init() async {
      await AccountManager().init(authCallback: (loginHistory) {
        widget.onLoginSuccess.call(loginHistory);
      });
      return true;
    }

    _onHistoryClick(LoginHistory loginHistory) async {
      await AccountManager().loginWithHistory(loginHistory);
      widget.onLoginSuccess.call(loginHistory);
    }

    return Scaffold(
      body: FutureBuilder(
        future: _init(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 42,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32, bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                "Accounts",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewLoginLayout(
                                            onLogin: widget.onLoginSuccess,
                                          )),
                                );
                              },
                              child: Text("New login"))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView(
                          children: AccountManager()
                              .loginHistoryManager
                              .list
                              .map((history) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceVariant,
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(16))),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                onTap: () => _onHistoryClick(history),
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                  child: Icon(
                                    Icons.person,
                                    color:Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                                title: Text(
                                  history.username!,
                                ),
                                subtitle: Text(
                                  history.apiUrl!,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
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
  final TextStyle? textStyle;
  final Icon? prefixIcon;

  const LoginInput({Key? key,
    this.onInputChange,
    this.hintText,
    this.activeColor,
    this.textStyle,
    this.prefixIcon,
    this.unactiveColor = Colors.white24,
    this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: activeColor ?? Theme
                  .of(context)
                  .primaryColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: unactiveColor, width: 1.0),
        ),
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
      cursorColor: activeColor ?? Theme
          .of(context)
          .primaryColor,
      onChanged: onInputChange,
      obscureText: obscureText,
    );
  }
}
