import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static final _instance = StorageService._internal();

  StorageService._internal();

  static StorageService getInstance() {
    return _instance;
  }

  final storage = FlutterSecureStorage();

  Future<String> get savedJwt async {
    try {
      var jwt = await storage.read(key: "jwt");
      if (jwt == null) return "";
      return jwt;
    } catch (e) {
      print(e);
    }
    return "";
  }

  Future<void> writeJwtToDb(String jwt) async {
    try {
      storage.write(key: "jwt", value: jwt);
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete() async {
    storage.delete(key: 'jwt');
  }
}
