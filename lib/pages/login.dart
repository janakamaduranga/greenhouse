import 'package:flutter/material.dart';
import 'package:green_house/pages/home.dart';
import 'package:green_house/services/rest_service.dart';
import 'package:green_house/services/storage_service.dart';
import 'package:green_house/util/jwt-util.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController =
      TextEditingController(text: 'janaka3.maduranga@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'SriLanka123');
  final RestService _restService = RestService.getInstance();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  void onLogin(BuildContext buildContext) async {
    var userName = _usernameController.text;
    var password = _passwordController.text;
    if (_formKey.currentState!.validate()) {
      var jwt = await _restService.getJWT(userName, password);

      if (jwt != null && JwtUtil.isValid(jwt)) {
        StorageService.getInstance().writeJwtToDb(jwt);
        //await Navigator.of(buildContext).pushNamed('/');
        await Navigator.push(
          buildContext,
          MaterialPageRoute(
              builder: (context) =>
                  Home(JwtUtil.getUserName(jwt), JwtUtil.getDeviceId(jwt))),
        );
      } else {
        displayDialog(buildContext, "An Error Occurred",
            "No account was found matching that username and password");
      }
    }
  }

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
                                  onPressed: () => onLogin(context),
                                  label: Text('Login'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Create New Account',
                        style: TextStyle(
                            color: Colors.black87,
                            decoration: TextDecoration.underline),
                      ),
                    )
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
