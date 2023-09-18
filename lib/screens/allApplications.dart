import 'dart:convert';

import 'package:domasna_mis_193008/models/Application.dart';
import 'package:domasna_mis_193008/models/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class AllApplications extends StatefulWidget {
  const AllApplications({Key? key}) : super(key: key);

  @override
  State<AllApplications> createState() => _AllApplicationsState();
}

class _AllApplicationsState extends State<AllApplications> {
  late SharedPreferences loginData;
  late String emailUser;
  late String firstNameUser;
  late String roleUser;

  late bool isFetched = false;


  void initState() {
    super.initState();
    initialState();
  }
  void initialState() async{
    loginData = await SharedPreferences.getInstance();
    emailUser = loginData.getString("username")!;
    firstNameUser = loginData.getString("firstName")!;
    roleUser = loginData.getString("role")!;



  }


  //FETCH FUNCTION - LIST ALL FESTIVALS
  late  List<Application> _applications = <Application>[];
  late bool first  = false;
  Future<List<Application>> fetchApplications() async{
    _applications  = <Application>[];
    var url ='http://192.168.1.53:8080/applications';
    var response = await http.get(url);
    var applications = <Application>[];
    if(response.statusCode==200)
    {

      var applicationsJson = json.decode(response.body);
      for(var applicationJson in applicationsJson)
      {
        applications.add(Application.fromJson(applicationJson));
      }

    }
    return applications;
  }



  @override
  Widget build(BuildContext context) {
    late User user;
    if(isFetched==false)
    {
      fetchApplications().then((value) {
        setState(() {
          _applications.addAll(value);
          isFetched = true;
        });
      });
    }

    return Scaffold(
      appBar:AppBar(
        title: const Text('All Applications',textAlign: TextAlign.center,),
        actions: [
          Padding(padding: EdgeInsets.all(5),child: Image.asset('assets/images/logo.png')),
        ],
      ),
      body: ListView.builder(
        itemCount: _applications.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text("Email: "+_applications[index].userEmail + "\nPhone:" + _applications[index].phone),
              subtitle: Text("Number of nights: "+_applications[index].numberOfNights +
                  "\nNumber of People: " + _applications[index].numberOfPeople + "\nCountry: "  + _applications[index].country+
                  "\nTransport: "  + _applications[index].transport),

              leading: Icon(Icons.email),
              onTap: () {
                // Navigate to a screen to edit the email
              },
            ),
          );
        },
      ),
    );

  }
}
