import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youplusauthplugin/youplusauthplugin.dart';
import 'package:youui/account/auth.dart';
import 'package:youui/account/entry.dart';
import 'package:youui/account/token.dart';
import 'dart:convert';

import 'info.dart';

class AccountManager {
  static final AccountManager _singleton = AccountManager._internal();
  Youplusauthplugin plugin = Youplusauthplugin();
  String serviceUrl = "";
  String serviceName = "";
  LoginHistoryManager loginHistoryManager = LoginHistoryManager();
  Function(LoginHistory)? authCallback;
  final Dio client = Dio();

  youplusLogin(String serviceUrl) {
    this.serviceUrl = serviceUrl;
  }


  _onAuthComplete(String username, token) async {
    LoginHistory loginHistory = LoginHistory(
        apiUrl: serviceUrl, username: username, token: token
    );
    await loginHistoryManager.add(loginHistory);
    authCallback?.call(loginHistory);
  }

  init({Function(LoginHistory)? authCallback}) async {
    await loginHistoryManager.refreshHistory();
    if (authCallback != null) {
      plugin.registerAuthCallback((username, token) {
        _onAuthComplete(username, token);
      });
    }
  }

  openYouPlus(String url) {
    serviceUrl = serviceUrl;
    plugin.openYouPlus();
  }


  Future<Info?> _getInfo() async {
    var response = await client.get("$serviceUrl/info");
    Info info = Info.fromJson(response.data);
    return info;
  }

  Future<Info?> _getService() async {
    Info? info = await _getInfo();
    if (info == null || !info.success) {
      return null;
    }
    if (info.name == "YouPlus service") {
      // find out entry of service
      var response = await client
          .get("$serviceUrl/entry", queryParameters: {"name": serviceName});
      FetchEntityByNameResponse fetchEntityByNameResponse =
      FetchEntityByNameResponse.fromJson(response.data);
      List<String>? urls = fetchEntityByNameResponse.entity?.export?.urls;
      if (urls == null) {
        return null;
      }
      // use can access urls
      for (var url in urls) {
        serviceUrl = url;
        Info? info = await _getInfo();
        if (info != null && !info.success) {
          return info;
        }
      }
    }
    return info;
  }

  Future<UserAuthResponse?> _getUserAuth(String username, password) async {
    var authResponse = await client.post("$serviceUrl/user/auth", data: {
      "username": username,
      "password": password,
    });
    UserAuthResponse userAuth = UserAuthResponse.fromJson(authResponse.data);
    bool? success = userAuth.success;
    if (success == null || !success) {
      return null;
    }
    return userAuth;
  }

  Future<LoginHistory?> login(String serviceUrl, String username,
      String password) async {
    this.serviceUrl = serviceUrl;
    final Info? info = await _getService();
    if (info == null || !info.success) {
      return null;
    }
    LoginHistory loginHistory =
    LoginHistory(apiUrl: serviceUrl, username: "Public");
    if (info.authEnable!) {
      UserAuthResponse? userAuth = await _getUserAuth(username, password);
      if (userAuth == null) {
        return null;
      }
      loginHistory.token = userAuth.token;
      loginHistory.username = username;
    }
    loginHistoryManager.add(loginHistory);
    return loginHistory;
  }

  Future<bool> loginWithHistory(LoginHistory loginHistory) async {
    final String? url = loginHistory.apiUrl;
    if (url == null) {
      return false;
    }
    serviceUrl = url;
    Info? info = await _getInfo();
    if (info == null || !info.success) {
      return false;
    }
    if (info.isAuthEnable()) {
      var tokenResponse = await client.get("$serviceUrl/user/auth",
          queryParameters: {"token": loginHistory.token});
      UserToken token = UserToken.fromJson(tokenResponse.data);
      if (!token.isSuccess()) {
        return false;
      }
    }
    return true;
  }

  AccountManager._internal();

  factory AccountManager() {
    return _singleton;
  }
}

class LoginHistory {
  String? apiUrl;
  String? username;
  String? token;

  LoginHistory({this.apiUrl, this.username, this.token});

  LoginHistory.fromJson(Map<String, dynamic> json) {
    apiUrl = json['apiUrl'];
    username = json['username'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() =>
      {'apiUrl': apiUrl, 'username': username, "token": token};
}

class LoginHistoryManager {
  List<LoginHistory> list = [];

  refreshHistory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? raw = sharedPreferences.getString("loginHistory");
    if (raw == null) {
      return;
    }
    List<dynamic> rawList = json.decode(raw);
    list = rawList.map((e) => LoginHistory.fromJson(e)).toList();
  }

  add(LoginHistory history) async {
    list.removeWhere((element) =>
    element.apiUrl == history.apiUrl &&
        element.username == history.username);
    list.insert(0, history);
    await save();
  }

  save() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String raw = jsonEncode(list);
    sharedPreferences.setString("loginHistory", raw);
  }
}
