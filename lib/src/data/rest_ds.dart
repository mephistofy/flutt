import 'dart:async';
import 'dart:convert';

import 'package:myapp/src/constant.dart';
import 'package:myapp/src/models/auth.dart';
import 'package:myapp/src/models/message.dart';
import 'package:myapp/src/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();

  Future<Auth> login(String email, String password) {
    var loginUrl = "$backendUrl/api/auth/sign_in";

    return _netUtil.post(loginUrl, body: {
      "email": email,
      "password": password,
    }).then((dynamic res) async {
      var body = jsonDecode(res.body);

      print(body.toString());

      if (body["error"] != null) throw new Exception(body["error_msg"]);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      final String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$email:$password'));
      await prefs.setString("basicAuth", basicAuth);
      await prefs.setBool("authState", true);

      return new Auth.map(res, basicAuth);
    });
  }

  Future<ListMessage> getMessages(int page) {
    var messageUrl = "$backendUrl/api/messages?page=$page";

    return _netUtil.get(messageUrl).then((dynamic res) {
      var body = jsonDecode(res.body);

      print(body.toString());
      if (body["error"] != null) throw new Exception(body["error_msg"]);

      return new ListMessage.map(body);
    });
  }

  Future logout() {
    var messageUrl = "$backendUrl/api/auth/sign_out";

    return _netUtil.delete(messageUrl).then((dynamic res) {
      var body = jsonDecode(res.body);

      print(body.toString());
      if (body["error"] != null) throw new Exception(body["error_msg"]);

      return;
    });
  }

  Future<dynamic> readAll() {
    var userRoomUrl = "$backendUrl/api/user_room";

    return _netUtil.put(userRoomUrl, body: {}).then((dynamic res) {
      try {
        var body = jsonDecode(res.body);
        print(body.toString());
        if (body["error"] != null) throw new Exception(body["error_msg"]);
        return body;
      } catch (_) {
        return {};
      }
    });
  }
}
