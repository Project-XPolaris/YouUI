import 'package:flutter/material.dart';

class WebOauthLoginView extends StatelessWidget {
  final Color? primaryColor;
  final Function() onLogin;
  const WebOauthLoginView({Key? key,required this.onLogin,this.primaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            child: Text('Login with Web Oauth'),
            onPressed: () {
              onLogin();
            },
            style: ElevatedButton.styleFrom(primary: primaryColor),
          )
        ],
      ),
    );
  }
}
