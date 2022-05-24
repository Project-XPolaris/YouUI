abstract class BaseResponse<T> {
  bool? success;
  String? token;
  T? data;
  T? convert(dynamic json);
  BaseResponse.fromJson(dynamic json) {
    success = json["success"];
    token = json["token"];
    data = convert(json["data"]);
  }
}