class FetchEntityByNameResponse {
  Entity? entity;
  bool? success;

  FetchEntityByNameResponse({
    this.entity,
    this.success});

  FetchEntityByNameResponse.fromJson(dynamic json) {
    entity = json["entity"] != null ? Entity.fromJson(json["entity"]) : null;
    success = json["success"];
  }
}

class Entity {
  String? name;
  String? state;
  String? instance;
  int? version;
  Export? export;

  Entity({
    this.name,
    this.state,
    this.instance,
    this.version,
    this.export});

  Entity.fromJson(dynamic json) {
    name = json["name"];
    state = json["state"];
    instance = json["instance"];
    version = json["version"];
    export = json["export"] != null ? Export.fromJson(json["export"]) : null;
  }
}

class Export {
  List<String> urls = [];
  Export({required this.urls});
  Export.fromJson(dynamic json) {
    urls = json["urls"] != null ? json["urls"].cast<String>() : [];
  }
}