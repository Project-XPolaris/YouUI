import 'package:flutter/material.dart';

import 'LoginLayout.dart';

class BaseLoginView extends StatefulWidget {
  final Color? textColor;
  final Color? primaryColor;
  final Color? outlineColor;
  final Function(String? username, String? password) onLoginClick;
  const BaseLoginView({Key? key,required this.onLoginClick,this.textColor,this.primaryColor,this.outlineColor}) : super(key: key);
  @override
  State<BaseLoginView> createState() => _BaseLoginViewState();
}

class _BaseLoginViewState extends State<BaseLoginView> {
  String? inputUsername;
  String? inputPassword;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: LoginInput(
              unactiveColor: Theme.of(context).colorScheme.surfaceVariant,
              activeColor: Theme.of(context).colorScheme.primary,
              prefixIcon: Icon(
                Icons.person,
              ),
              onInputChange: (text) {
                setState(() {
                  inputUsername = text;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: LoginInput(
              unactiveColor: Theme.of(context).colorScheme.surfaceVariant,
              activeColor: Theme.of(context).colorScheme.primary,
              prefixIcon: Icon(
                Icons.lock,
              ),
              onInputChange: (text) {
                setState(() {
                  inputPassword = text;
                });
              },
              obscureText: true,
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16),
            child: ElevatedButton(
              child: Text(
                'Login',
              ),
              onPressed: () {
                this.widget.onLoginClick(inputUsername, inputPassword);
              },
            ),
          ),
        ],
      ),
    );
  }
}
