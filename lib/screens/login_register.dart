
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:domasna_mis_193008/widgets/my_textField.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/User.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late SharedPreferences loginData;

  bool isLogin = true;
  String? errorMessage = "";
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    initialState();
  }

  void initialState() async {
    loginData = await SharedPreferences.getInstance();
  }

  Future<void> findUserByEmail(String email) async {
    var url = 'http://192.168.1.53:8080/users/$email';
    var response = await http.get(url);
    User user;
    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      user = User.fromJson(userJson);
      loginData.setString("role", user.role);
      loginData.setString("firstName", user.firstName);
      loginData.setString("lastName", user.lastName);
    }


  }

  Future<void> signInWithEmailAndPassword() async {
    var url = 'http://192.168.1.53:8080/auth';
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );
    if (response.statusCode == 200) {
      if (response.body == "true") {
         await findUserByEmail(_emailController.text);

        // sharedPreferences.setString("loggedUser", _emailController.text);
        loginData.setString("username", _emailController.text);
        loginData.setString("password", _passwordController.text);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomePage()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'You have successfully logged in ${_emailController.text}')));
      }
      else {
        setState(() {
          errorMessage = "The user doesn't exist";
        });
      }
    }
  }

  //
  Future<void> createUserWithEmailAndPassword() async {
    var url = 'http://192.168.1.53:8080/auth/register';
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );
    if (response.statusCode == 200) {
      if (response.body == "true") {
        // sharedPreferences.setString("loggedUser", _emailController.text);
        await findUserByEmail(_emailController.text);
        loginData.setString("username", _emailController.text);
        loginData.setString("password", _passwordController.text);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomePage()));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'You have successfully created your account ${_emailController
                    .text}')));
      }
      else {
        setState(() {
          errorMessage = "The user doesn't exist";
        });
      }
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage',
      style: TextStyle(fontSize: 20, color: Colors.red),);
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Login' : 'Register'));
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Register instead' : 'Login instead'));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.blue[50],
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  //logo
                  Padding(padding: EdgeInsets.all(5),
                      child: Image.asset(
                        'assets/images/logo.png', height: 150, width: 200,)),
                  const SizedBox(height: 30),
                  Text(
                    "Welcome back, you've been missed!",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700]
                    ),
                  ),
                  const SizedBox(height: 25),
                  //emailField
                  MyTextField(
                    controller: _emailController,
                    hintText: "Username",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),
                  //passwordField
                  MyTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot your password?",
                        style: TextStyle(color: Colors.grey[700]),),
                      SizedBox(width: 25,)
                    ],
                  ),
                  //forgotPassword
                  const SizedBox(height: 25),
                  _errorMessage(),
                  _submitButton(),
                  _loginOrRegisterButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
