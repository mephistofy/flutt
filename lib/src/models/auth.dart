import 'dart:convert';

class Auth {
  int _id;
  String _email;
  String _name;
  String _avatar;
  String _basicAuth;

  Auth.map(dynamic response, String basicAuth) {
    var obj = jsonDecode(response.body)["data"];

    this._id = obj["id"];
    this._email = obj["email"];
    this._name = obj["name"];
    this._avatar = obj["avatar"];
    this._basicAuth = basicAuth;
  }

  Auth.fromMap(dynamic obj) {
    this._id = obj["id"];
    this._email = obj["email"];
    this._name = obj["name"];
    this._avatar = obj["avatar"];
  }

  int get id => _id;
  String get email => _email;
  String get name => _name;
  String get avatar => _avatar;
  String get basicAuth => _basicAuth;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["email"] = _email;
    map["name"] = _name;
    map["avatar"] = _avatar;
    map["basicAuth"] = _basicAuth;

    return map;
  }
}
