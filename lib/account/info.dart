class Info {
  String? name;
  bool success = false;
  bool? authEnable;
  String? authUrl;

  Info.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    authEnable = json['authEnable'];
    authUrl = json['authUrl'];
    success = json['success'];
  }
  bool isAuthEnable(){
    bool? enable = authEnable;
    if (enable == null) {
      return false;
    }
    return enable;
  }
}