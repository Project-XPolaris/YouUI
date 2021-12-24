class UserAuthResponse {
  bool? success;
  String? token;
  String? uid;

  UserAuthResponse({
    this.success,
    this.token,
    this.uid});

  UserAuthResponse.fromJson(dynamic json) {
    success = json["success"];
    token = json["token"];
    uid = json["uid"];
  }
}