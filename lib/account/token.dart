class UserToken {
  bool? success;
  String? uid;
  String? username;

  UserToken({
    this.success,
    this.uid,
    this.username});

  UserToken.fromJson(dynamic json) {
    success = json["success"];
    uid = json["uid"];
    username = json["username"];
  }
  bool isSuccess(){
    bool? value = success;
    if (value == null) {
      return false;
    }
    return value;
  }
}