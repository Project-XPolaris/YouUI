import 'package:youui/account/base.dart';

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
class OauthData {
  String? accessToken;
  String? username;
  OauthData.fromJson(dynamic json) {
    accessToken = json["accessToken"];
    username = json["username"];
  }
}
class OauthTokenResponse extends BaseResponse<OauthData> {
  OauthTokenResponse.fromJson(json) : super.fromJson(json);
  @override
  OauthData? convert(json) {
    return OauthData.fromJson(json);
  }
}