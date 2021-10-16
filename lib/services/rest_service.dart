import 'package:green_house/models/Command.dart';
import 'package:green_house/models/Device.dart';
import 'package:green_house/util/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

const SERVER_IP = 'http://10.0.2.2:8080';

class RestService {
  static final _instance = RestService._internal();

  RestService._internal();

  static RestService getInstance() {
    return _instance;
  }

  Future<Reading> getReadings(String? jwt, String? deviceId) async {
    try {
      var url = Uri.parse("$SERVER_IP/user/readings/$deviceId");
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $jwt'
      });
      if (response.statusCode == 200) {
        String responseBody = response.body;
        var jsonMap = json.decode(responseBody);
        return Reading(
            jsonMap["deviceId"], jsonMap["temperature"], jsonMap["humidity"]);
      }
    } catch (Exception) {}
    return Reading(deviceId!, -1.00, -1.00);
  }

  Future<String?> getJWT(String userName, String password) async {
    var body =
        json.encode(<String, String>{'email': userName, 'password': password});

    try {
      var res = await http.post(Uri.parse("$SERVER_IP/signIn"),
          body: body,
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });
      if (res.statusCode == 200) {
        var map = json.decode(res.body);
        return map['token'];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> saveCommand(String? jwt, Command command) async {
    var body = json.encode(<String, dynamic>{
      'deviceId': command.deviceId,
      'actions': command.actions
    });

    try {
      var res = await http
          .post(Uri.parse("$SERVER_IP/user/commands"), body: body, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer $jwt'
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> saveUser(User user) async {
    var body = json.encode(<String, dynamic>{
      'email': user.userName,
      'password': user.password,
      'mobile': user.mobile,
      'address': user.address,
      'deviceId': user.deviceId
    });

    try {
      var res = await http.post(Uri.parse("$SERVER_IP/signup"),
          body: body,
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });
      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
