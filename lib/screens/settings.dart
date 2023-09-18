import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SharedPreferences loginData;
  late String emailUser;
  late String passwordUser;
  //INIT STATE
  @override
  void initState() {
    super.initState();
    initialState();
  }
  void initialState() async{
    loginData = await SharedPreferences.getInstance();
    emailUser = loginData.getString("username")!;
    passwordUser = loginData.getString("password")!;


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Email'),
            subtitle: Text(emailUser.toString()),
            leading: Icon(Icons.email),
            onTap: () {
              // Navigate to a screen to edit the email
            },
          ),
          ListTile(
            title: Text('Password'),
            subtitle: Text(passwordUser.toString()),
            leading: Icon(Icons.lock),
            onTap: () {
              // Navigate to a screen to change the password
            },
          ),
          // Add more ListTile widgets for other profile information
        ],
      ),
    );
  }
}

