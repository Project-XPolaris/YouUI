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
    uid = json["id"];
  }
}
class OauthData {
  String? accessToken;
  String? username;
  String? uid;
  OauthData.fromJson(dynamic json) {
    accessToken = json["accessToken"];
    username = json["username"];
    uid = json["id"];
  }
}
class OauthTokenResponse extends BaseResponse<OauthData> {
  OauthTokenResponse.fromJson(json) : super.fromJson(json);
  @override
  OauthData? convert(json) {
    return OauthData.fromJson(json);
  }
}