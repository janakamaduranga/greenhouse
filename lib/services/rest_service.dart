import 'package:http/http.dart' as http;
import 'dart:convert' show json;

const SERVER_IP = 'http://10.0.2.2:8081';

class RestService {
  static final _instance = RestService._internal();

  RestService._internal();

  static RestService getInstance() {
    return _instance;
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
}
