import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  Future<http.Response> get(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String basicAuth = (prefs.getString('basicAuth') ?? "");

    return http.get(Uri.parse(url), headers: <String, String>{
      'authorization': basicAuth
    }).then((http.Response response) {
      return handleResponse(response);
    });
  }

  Future<http.Response> post(String url, {body, encoding}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String basicAuth = (prefs.getString('basicAuth') ?? "");

    return http
        .post(Uri.parse(url),
            body: body,
            headers: <String, String>{'authorization': basicAuth},
            encoding: encoding)
        .then((http.Response response) {
      return handleResponse(response);
    });
  }

  Future<http.Response> delete(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String basicAuth = (prefs.getString('basicAuth') ?? "");

    return http.delete(Uri.parse(url), headers: <String, String>{
      'authorization': basicAuth
    }).then((http.Response response) {
      return handleResponse(response);
    });
  }

  Future<http.Response> put(String url, {body, encoding}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String basicAuth = (prefs.getString('basicAuth') ?? "");

    return http
        .put(Uri.parse(url),
            body: body,
            headers: <String, String>{'authorization': basicAuth},
            encoding: encoding)
        .then((http.Response response) {
      return handleResponse(response);
    });
  }

  http.Response handleResponse(http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode == 401) {
      throw new Exception("Unauthorized");
    } else if (statusCode != 200) {
      throw new Exception("Error while fetching data");
    }

    return response;
  }
}
