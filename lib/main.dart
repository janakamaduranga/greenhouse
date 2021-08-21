import 'package:flutter/material.dart';
import 'package:green_house/pages/home.dart';
import 'package:green_house/pages/login.dart';
import 'package:green_house/services/storage_service.dart';
import 'package:green_house/util/jwt-util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final StorageService _storageService = StorageService.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/loginPage': (context) => Login(),
      },
      home: FutureBuilder<String>(
        future: _storageService.savedJwt,
        builder: (context, snapshot) {
          var jwtToken = snapshot.data;
          if (jwtToken != null && JwtUtil.isValid(jwtToken)) {
            return Home(
              JwtUtil.getUserName(jwtToken),
              JwtUtil.getDeviceId(jwtToken),
            );
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
