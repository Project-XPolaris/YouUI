import 'package:flutter/material.dart';
import 'package:youui/account/info.dart';
import 'package:youui/account/store.dart';
import 'package:youui/layout/login/BaseLoginView.dart';
import 'package:youui/layout/login/WebOauthLoginView.dart';

import '../../components/oauth-web-login.dart';

class NewLoginLayout extends StatefulWidget {
  final Function(LoginHistory history) onLogin;

  const NewLoginLayout({Key? key, required this.onLogin}) : super(key: key);

  @override
  State<NewLoginLayout> createState() => _NewLoginLayoutState();
}

class _NewLoginLayoutState extends State<NewLoginLayout> {
  String inputUrl = "";
  Info? serviceInfo;

  @override
  Widget build(BuildContext context) {
    List<String> hostList = [];
    AccountManager().loginHistoryManager.list.forEach((element) {
      final apiUrl = element.apiUrl;
      if (apiUrl != null && !hostList.contains(apiUrl)) {
        hostList.add(apiUrl);
      }
    });
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
      if (!uri.hasScheme) {
        inputUrl = "http://" + inputUrl;
      }
      return inputUrl;
    }

    _onConnectClick({String? targetUrl}) async {
      String? serviceUrl = targetUrl;
      if (serviceUrl == null) {
        String? url = _getInputUrl();
        if (url == null) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please enter a valid url")));
          return;
        }
        serviceUrl = url;
      }

      AccountManager().serviceUrl = serviceUrl;
      var info = await AccountManager().getInfo();
      if (info != null) {
        setState(() {
          serviceInfo = info;
        });
      }
    }

    _onOauthLoginResult(String authCode) async {
      final String? serviceUrl = AccountManager().serviceUrl;
      if (serviceUrl == null) {
        return;
      }
      LoginHistory? loginAccount =
          await AccountManager().loginWithYouAuth(serviceUrl, authCode);
      if (loginAccount == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("login error")));
        return;
      }
      widget.onLogin(loginAccount);
    }

    Widget renderUsernamePasswordLogin(AuthInfo info) {
      return BaseLoginView(
        onLoginClick: (username, password) async {
          if (username == null || password == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please enter username and password")));
            return;
          }
          LoginHistory? history = await AccountManager().login(
              AccountManager().serviceUrl, info.url!, username, password);
          if (history != null) {
            widget.onLogin(history);
          }
        },
      );
    }

    Widget renderWebOauthLogin(AuthInfo info) {
      return WebOauthLoginView(
        onLogin: () async {
          final String? oauthUrl = info.url;
          if (oauthUrl == null) {
            return;
          }
          var oauthTarget = Uri.parse(oauthUrl);
          oauthTarget = oauthTarget.replace(queryParameters: {
            ...oauthTarget.queryParameters,
            "redirect": ""
          });
          // nav to in app web view
          final code = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => WebOauthWindow(
                    oauthUrl: oauthTarget.toString(),
                  )));
          if (code != null) {
            _onOauthLoginResult(code);
          }
          // final result = await FlutterWebAuth.authenticate(
          //     url: oauthTarget.toString(),
          //     callbackUrlScheme: widget.oauthCallbackScheme);
          // final code = Uri.parse(result).queryParameters['code'];
          // if (code != null) {
          //   _onOauthLoginResult(code);
          // }
        },
      );
    }

    Widget renderAnomymousLogin() {
      return Container(
        child: Column(
          children: [
            ElevatedButton(
              child: Text("Anonymous Login"),
              onPressed: () async {
                // LoginHistory? history = await AccountManager().login(
                //     AccountManager().serviceUrl, info.url!, null, null);
                // if (history != null) {
                //   widget.onLogin(history);
                // }
              },
            )
          ],
        ),
      );
    }

    List<Widget> renderSelectHost() {
      return [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(const Radius.circular(16)),
              color: Theme.of(context).colorScheme.surfaceVariant),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Service url',
                    ),
                    onChanged: (value) {
                      inputUrl = value;
                    },
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 48,
                  height: 48,
                  child: const Center(
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
                onTap: () {
                  _onConnectClick(targetUrl: _getInputUrl());
                },
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16),
          child: const Text(
            "History hosts",
            style: TextStyle(),
          ),
        ),
        Expanded(
            child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            for (final host in hostList)
              GestureDetector(
                onTap: () {
                  _onConnectClick(targetUrl: host);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(16)),
                      color: Theme.of(context).colorScheme.surfaceVariant),
                  child: Text(
                    host,
                    style: TextStyle(),
                  ),
                ),
              )
          ],
        ))
      ];
    }

    List<Widget> renderLogin() {
      final auths = serviceInfo?.auths ?? [];
      Widget loginContent = Container();
      if (auths.length > 1) {
        List<Widget> tabs = [];
        for (var element in auths) {
          switch (element.type) {
            case "weboauth":
              tabs.add(Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: renderWebOauthLogin(element),
              ));
              break;
            case "base":
              tabs.add(Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: renderUsernamePasswordLogin(element),
              ));
              break;
            case 'anonymous':
              tabs.add(Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      widget.onLogin(AccountManager().anonymousLogin());
                    },
                    child: Text("Anonymous Login"),
                  ),
                ],
              ));
              break;
            default:
              break;
          }
        }
        loginContent = DefaultTabController(
          length: tabs.length,
          child: Container(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Theme.of(context).colorScheme.surfaceVariant),
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Icon(
                        Icons.cloud,
                      ),
                      title:
                          Text(AccountManager().serviceUrl, style: TextStyle()),
                      trailing: GestureDetector(
                        child: Icon(
                          Icons.close,
                        ),
                        onTap: () {
                          setState(() {
                            serviceInfo = null;
                          });
                        },
                      ),
                    )),
                TabBar(
                  tabs: [
                    for (var value in auths)
                      Tab(
                        text: value.name,
                      )
                  ],
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  labelColor: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: TabBarView(
                      children: tabs,
                    ),
                  ),
                ))
              ],
            ),
          ),
        );
      }
      if (auths.length == 1) {
        Widget content = Container();
        switch (auths[0].type) {
          case "weboauth":
            content = renderWebOauthLogin(auths[0]);
            break;
          case "base":
            content = renderUsernamePasswordLogin(auths[0]);
            break;
          case "anonymous":
            content = Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.onLogin(AccountManager().anonymousLogin());
                  },
                  child: Text("Anonymous Login"),
                ),
              ],
            );
            break;
          default:
            break;
        }
        loginContent = Container(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Theme.of(context).colorScheme.surfaceVariant),
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(
                      Icons.cloud,
                    ),
                    title:
                        Text(AccountManager().serviceUrl, style: TextStyle()),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.close,
                      ),
                      onTap: () {
                        setState(() {
                          serviceInfo = null;
                        });
                      },
                    ),
                  )),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: content,
                ),
              ))
            ],
          ),
        );
      }

      return [
        Expanded(
            child: Container(
          child: loginContent,
        ))
      ];
    }

    List<Widget> renderContent() {
      if (serviceInfo == null) {
        return renderSelectHost();
      }
      return renderLogin();
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(top: 48, bottom: 32),
                  child: Text("New Login",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w300))),
              ...renderContent()
            ]),
      ),
    );
  }
}
