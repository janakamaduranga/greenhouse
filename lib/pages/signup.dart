import 'package:flutter/material.dart';
import 'package:green_house/pages/login.dart';
import 'package:green_house/services/rest_service.dart';
import 'package:green_house/util/user.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController =
      TextEditingController(text: 'janaka11.maduranga@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'SriLanka123');
  final TextEditingController _passwordConfirmController =
      TextEditingController(text: 'SriLanka123');
  final TextEditingController _deviceIdController =
      TextEditingController(text: '12345');
  final TextEditingController _mobileController =
      TextEditingController(text: '0760516672');
  final TextEditingController _addressController =
      TextEditingController(text: 'no : 107, 4th Lane, Dickhenapura Horana');
  final RestService _restService = RestService.getInstance();

  void signUp(BuildContext buildContext) async {
    var userName = _usernameController.text;
    var password = _passwordController.text;
    var mobile = _mobileController.text;
    var address = _addressController.text;
    var deviceId = _deviceIdController.text;

    var user = User(userName, password, mobile, address, deviceId);

    if (_formKey.currentState!.validate()) {
      var status = await _restService.saveUser(user);

      if (status) {
        await Navigator.push(
          buildContext,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        displayDialog(buildContext, "An Error Occurred", "Signup Failure");
      }
    }
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Green_house.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "username can not be empty";
                          }
                          return null;
                        },
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'username',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "password can not be empty";
                          }
                          return null;
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'password',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "password can not be empty";
                          } else if (value != _passwordController.text) {
                            return "passwords do not match";
                          }
                          return null;
                        },
                        controller: _passwordConfirmController,
                        decoration: InputDecoration(
                          hintText: 'password confirm',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "mobile can not be empty";
                          }
                          return null;
                        },
                        controller: _mobileController,
                        decoration: InputDecoration(
                          hintText: 'mobile',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "deviceId can not be empty";
                          }
                          return null;
                        },
                        controller: _deviceIdController,
                        decoration: InputDecoration(
                          hintText: 'device Id',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          hintText: 'address',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                width: 100,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue),
                                  icon: Icon(
                                    Icons.login,
                                    color: Colors.black,
                                  ),
                                  onPressed: () => signUp(context),
                                  label: Text('SignUp'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
