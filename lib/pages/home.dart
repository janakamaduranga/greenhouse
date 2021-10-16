import 'package:flutter/material.dart';
import 'package:green_house/pages/green_reading.dart';
import 'package:green_house/pages/nav_drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Green House'),
      ),
      body: GreenHouseReading(),
    );
  }
}
