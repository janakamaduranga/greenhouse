import 'package:flutter/material.dart';
import 'package:green_house/models/Command.dart';
import 'package:green_house/models/Device.dart';
import 'package:green_house/models/UserAction.dart';
import 'package:green_house/services/rest_service.dart';
import 'package:green_house/util/Device.dart';
import 'package:green_house/util/UserContext.dart';

class GreenHouseReading extends StatefulWidget {
  @override
  _GreenHouseReadingState createState() => _GreenHouseReadingState();
}

class _GreenHouseReadingState extends State<GreenHouseReading> {
  var _formKey = GlobalKey<FormState>();
  final TextEditingController _temporatureController = TextEditingController();
  final TextEditingController _humidityController = TextEditingController();
  bool fanIsSwitched = false;
  bool roofIsSwitched = false;

  void fanToggleSwitch(bool value) {
    if (fanIsSwitched == false) {
      setState(() {
        fanIsSwitched = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        fanIsSwitched = false;
      });
      print('Switch Button is OFF');
    }
  }

  void roofToggleSwitch(bool value) {
    if (roofIsSwitched == false) {
      setState(() {
        roofIsSwitched = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        roofIsSwitched = false;
      });
      print('Switch Button is OFF');
    }
  }

  void refresh() async {
    Future<Reading> reading = RestService.getInstance().getReadings(
        UserContext.getInstance().getJwt(),
        UserContext.getInstance().getDeviceId());
    reading.then((value) => setState(() {
          _temporatureController.text = value.temporature.toString();
          _humidityController.text = value.humidity.toString();
        }));
  }

  void save(BuildContext context) async {
    List<UserAction> actions = [];
    actions.add(UserAction(Device.FAN, fanIsSwitched ? "1" : "0"));
    actions.add(UserAction(Device.ROOF, roofIsSwitched ? "1" : "0"));

    var status = await RestService.getInstance().saveCommand(
        UserContext.getInstance().getJwt(),
        Command(UserContext.getInstance().deviceId.toString(), actions));

    if (status) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Saved successfully"),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Failed"),
              content: Text("Failure occure in saving"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Reading>(
      future: RestService.getInstance().getReadings(
          UserContext.getInstance().getJwt(),
          UserContext.getInstance().getDeviceId()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Reading? reading = snapshot.data;

          if (reading != null) {
            _temporatureController.text = reading.temporature.toString();
            _humidityController.text = reading.humidity.toString();
            return Container(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Temporature'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              controller: _temporatureController,
                              decoration: InputDecoration(
                                hintText: 'temporature',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                enabled: false,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 120,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Fan On/Off'),
                            ),
                          ),
                          Switch(
                            onChanged: fanToggleSwitch,
                            value: fanIsSwitched,
                            activeColor: Colors.blue,
                            activeTrackColor: Colors.yellow,
                            inactiveThumbColor: Colors.redAccent,
                            inactiveTrackColor: Colors.orange,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Humidity'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              controller: _humidityController,
                              decoration: InputDecoration(
                                  hintText: 'humidity',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  enabled: false),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 120,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Roof On/Off'),
                            ),
                          ),
                          Switch(
                            onChanged: roofToggleSwitch,
                            value: roofIsSwitched,
                            activeColor: Colors.blue,
                            activeTrackColor: Colors.yellow,
                            inactiveThumbColor: Colors.redAccent,
                            inactiveTrackColor: Colors.orange,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue),
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.black,
                              ),
                              onPressed: refresh,
                              label: Text('Refresh'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue),
                              icon: Icon(
                                Icons.save,
                                color: Colors.black,
                              ),
                              onPressed: () => save(context),
                              label: Text('Save'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return Container(
          child: Column(children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'No data found'),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black,
                ),
                onPressed: refresh,
                label: Text('Refresh'),
              ),
            ),
          ]),
        );
      },
    );
  }
}
