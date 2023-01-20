import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youplusauthplugin/youplusauthplugin.dart';
import 'package:youui/account/auth.dart';
import 'package:youui/account/entry.dart';
import 'package:youui/account/token.dart';
import 'dart:convert';

import 'info.dart';

class UserLoginResult {
  bool success = false;
  String message = "";
  String token = "";
}

class AccountManager {
  static final AccountManager _singleton = AccountManager._internal();
  Youplusauthplugin plugin = Youplusauthplugin();
  String serviceUrl = "";
  String serviceName = "";
  String userAuthPath = "/user/auth";
  String getCurrentUserPath = "/user/auth";
  LoginHistoryManager loginHistoryManager = LoginHistoryManager();
  Function(LoginHistory)? authCallback;
  final Dio client = Dio();
  Future<LoginHistory?> Function(
      String serviceUrl, String username, String password)? onLogin;

  youplusLogin(String serviceUrl) {
    this.serviceUrl = serviceUrl;
  }

  _onAuthComplete(String username, token) async {
    LoginHistory loginHistory =
        LoginHistory(apiUrl: serviceUrl, username: username, token: token);
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

  Future<Info?> getInfo() async {
    var response = await client.get("$serviceUrl/info");
    Info info = Info.fromJson(response.data);
    return info;
  }

  Future<Info?> _getService() async {
    Info? info = await getInfo();
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
        Info? info = await getInfo();
        if (info != null && !info.success) {
          return info;
        }
      }
    }
    return info;
  }

  Future<OauthTokenResponse?> _getUserAuth(
      String path, String username, password) async {
    print("$serviceUrl$path");
    print(username);
    print(password);
    var authResponse = await client.post("$serviceUrl$path", data: {
      "username": username,
      "password": password,
    }, queryParameters: {
      "type": "accessToken"
    });
    OauthTokenResponse userAuth =
        OauthTokenResponse.fromJson(authResponse.data);
    bool? success = userAuth.success;
    if (success == null || !success) {
      return null;
    }
    return userAuth;
  }

  Future<OauthData?> _getOauthToken(String code) async {
    var response = await client
        .get("$serviceUrl/oauth/youauth", queryParameters: {"code": code});
    OauthTokenResponse oauthTokenResponse =
        OauthTokenResponse.fromJson(response.data);
    bool? success = oauthTokenResponse.success;
    if (success == null || !success) {
      return null;
    }
    return oauthTokenResponse.data;
  }

  Future<LoginHistory?> login(
      String serviceUrl, String path, String username, String password) async {
    this.serviceUrl = serviceUrl;
    final Info? info = await _getService();
    if (info == null || !info.success) {
      return null;
    }
    final customLogin = onLogin;
    if (customLogin != null) {
      return customLogin(serviceUrl, username, password);
    }
    LoginHistory loginHistory =
        LoginHistory(apiUrl: serviceUrl, username: "Public");

    OauthTokenResponse? userAuth = await _getUserAuth(path, username, password);
    if (userAuth == null) {
      return null;
    }
    loginHistory.token = userAuth.data!.accessToken;
    loginHistory.username = userAuth.data!.username;
    loginHistory.id = userAuth.data!.uid;
    loginHistoryManager.add(loginHistory);
    return loginHistory;
  }

  LoginHistory anonymousLogin() {
    LoginHistory history =
        LoginHistory(username: "anonymous", apiUrl: serviceUrl);
    loginHistoryManager.add(history);
    return history;
  }

  Future<bool> loginWithHistory(LoginHistory loginHistory) async {
    final String? url = loginHistory.apiUrl;
    if (url == null) {
      return false;
    }
    serviceUrl = url;
    Info? info = await getInfo();
    if (info == null || !info.success) {
      return false;
    }
    if (info.isAuthEnable()) {
      var tokenResponse = await client.get("$serviceUrl$getCurrentUserPath",
          queryParameters: {"token": loginHistory.token});
      UserToken token = UserToken.fromJson(tokenResponse.data);
      if (!token.isSuccess()) {
        return false;
      }
    }
    return true;
  }

  Future<LoginHistory?> loginWithYouAuth(
      String serviceUrl, String authCode) async {
    this.serviceUrl = serviceUrl;
    final Info? info = await _getService();
    if (info == null || !info.success) {
      return null;
    }
    LoginHistory loginHistory =
        LoginHistory(apiUrl: serviceUrl, username: "Public");
    bool? isAuthEnable = info.authEnable;

    OauthData? userAuth = await _getOauthToken(authCode);
    if (userAuth == null) {
      return null;
    }
    loginHistory.token = userAuth.accessToken;
    loginHistory.username = userAuth.username;
    loginHistory.id = userAuth.uid;
    loginHistoryManager.add(loginHistory);
    return loginHistory;
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
  String? id;

  LoginHistory({this.apiUrl, this.username, this.token});

  LoginHistory.fromJson(Map<String, dynamic> json) {
    apiUrl = json['apiUrl'];
    username = json['username'];
    token = json['token'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() =>
      {'apiUrl': apiUrl, 'username': username, "token": token,"id":id};
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
