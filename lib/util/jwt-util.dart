import 'dart:convert' show json, base64, ascii;

class JwtUtil {
  JwtUtil._();

  static bool isValid(String? jwt) {
    if (jwt!.isEmpty) return false;

    var payLoad = _getPayload(jwt);

    if (payLoad != null) {
      if (DateTime.fromMillisecondsSinceEpoch(payLoad["exp"] * 1000)
          .isAfter(DateTime.now())) {
        return true;
      }
    }
    return false;
  }

  static dynamic _getPayload(String jwt) {
    if (jwt.isEmpty) return null;
    var jwtParts = jwt.split(".");

    if (jwtParts.length == 3) {
      return json
          .decode(ascii.decode(base64.decode(base64.normalize(jwtParts[1]))));
    }
  }

  static String getDeviceId(String jwt) {
    if (jwt.isEmpty) return "";

    var payLoad = _getPayload(jwt);
    if (payLoad != null) {
      return payLoad["DEVICE_ID"];
    }
    return "";
  }

  static String getUserName(String jwt) {
    if (jwt.isEmpty) return "";

    var payLoad = _getPayload(jwt);
    if (payLoad != null) {
      return payLoad["sub"];
    }
    return "";
  }
}
