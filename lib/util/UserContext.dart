class UserContext {
  String? userName;
  String? jwt;
  String? deviceId;
  static final _instance = UserContext._internal();

  UserContext._internal();

  static UserContext getInstance() {
    return _instance;
  }

  void setContextData(String? userName, String? jwt, String? deviceId) {
    this.userName = userName;
    this.jwt = jwt;
    this.deviceId = deviceId;
  }

  String? getUserName() {
    return this.userName;
  }

  String? getJwt() {
    return this.jwt;
  }

  String? getDeviceId() {
    return this.deviceId;
  }
}
