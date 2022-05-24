class AuthInfo {
  late String type;
  late String? url;
  late String name;
  AuthInfo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
    name = json['name'];
  }
}
class Info {
  String? name;
  bool success = false;
  bool? authEnable;
  String? authUrl;
  bool? _oauth;
  String? oauthUrl;
  List<AuthInfo> auths = [];
  Info.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    authEnable = json['authEnable'];
    authUrl = json['authUrl'];
    success = json['success'];
    _oauth = json['oauth'];
    oauthUrl = json['oauthUrl'];
    for (var item in json['auth']) {
      auths.add(AuthInfo.fromJson(item));
    }
  }
  bool isAuthEnable(){
    bool? enable = authEnable;
    if (enable == null) {
      return false;
    }
    return enable;
  }
  bool get oauth => _oauth ?? false;
}