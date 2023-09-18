

import 'dart:convert';

import 'package:domasna_mis_193008/auth.dart';
import 'package:domasna_mis_193008/models/Application.dart';
import 'package:domasna_mis_193008/models/Festival.dart';
import 'package:domasna_mis_193008/screens/about.dart';
import 'package:domasna_mis_193008/screens/allApplications.dart';
import 'package:domasna_mis_193008/screens/login_register.dart';
import 'package:domasna_mis_193008/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
   late bool isFetched = false;
   late SharedPreferences loginData;
   late String emailUser;
   late String firstNameUser;
   late String roleUser = "";


//INIT STATE

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


//CONTROLLERS CREATE FESTIVAL
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
   final TextEditingController _descriptionController = TextEditingController();
   final TextEditingController _locationController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  //CONTROLLERS CREATE APPLICATION
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _nightsController = TextEditingController();
  final TextEditingController _transportController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();















  //FETCH FUNCTION - LIST ALL FESTIVALS
  late  List<Festival> _festivals = <Festival>[];
  late bool first  = false;
  Future<List<Festival>> fetchFestivals() async{
    _festivals = <Festival>[];
    var url ='http://192.168.1.53:8080/events';
    var response = await http.get(url);
    var festivals = <Festival>[];
    if(response.statusCode==200)
      {

        var festivaliJson = json.decode(response.body);
        for(var festivalJson in festivaliJson)
          {
            festivals.add(Festival.fromJson(festivalJson));
          }

      }
    return festivals;
  }
//APPLICATION FORM
  Future<void> _createApplication(String festivalId) async {



    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery
                    .of(ctx)
                    .viewInsets
                    .bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',hintText: "Enter a number",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _nightsController,
                  decoration: const InputDecoration(
                    labelText: 'Number Of Nights',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _peopleController,
                  decoration: const InputDecoration(
                    labelText: 'Number Of People',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller:_transportController ,
                  decoration: const InputDecoration(
                    labelText: 'Transport By',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller:_countryController ,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: const Text('SEND'),
                  onPressed: () async {

                    final String fullName = _fullNameController.text;
                    final String phone = _phoneController.text;
                    final String numbPeople = _peopleController.text;
                    final String numbNights = _nightsController.text;
                    final String transport = _transportController.text;
                    final String country = _countryController.text;

                    if (fullName != null && phone != null && numbPeople != null &&
                        numbNights != null && numbNights != null && transport != null && country != null) {
                      Application application = Application(fullName, phone, numbPeople,numbNights, transport, country, loginData.get("email").toString());
                      // Persist a new product to Firestore
                      var url = 'http://192.168.1.53:8080/applications/create';
                      var response = await http.post(
                        url,
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{
                          'fullName': application.fullName,
                          'phone': application.phone,
                          'numberOfPeople':application.numberOfPeople,
                          'numberOfNights':application.numberOfNights,
                          'transport':application.transport,
                          'country' : application.country,
                          'userEmail' :  loginData.get("email").toString()
                        }),
                      );
                      setState(() {
                        isFetched=false;
                      });
                      // If the server did return a 201 CREATED response,
                    }

                    // if (action == 'update') {
                    //   // Update the product
                    //   await _festivals
                    //       .doc(documentSnapshot!.id)
                    //       .update({"title": title, "price": price});
                    // }

                    // Clear the text fields
                    // _titleController.text = '';
                    // _priceController.text = '';
                    // _imageController.text = '';
                    // _locationController.text = '';
                    // _descriptionController.text = '';

                    // Hide the bottom sheet
                    Navigator.of(context).pop();

                    //INFO ABOUT WHAT HAPPENED
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('You have successfully created an application')));
                  },
                )
              ],
            ),
          );
        });
  }


  //ADD NEW FESTIVAL

  Future<void> _createFestival() async {


    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery
                    .of(ctx)
                    .viewInsets
                    .bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descritpion',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _imageController,
                  decoration: const InputDecoration(
                    labelText: 'Image',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String title = _titleController.text;
                    final String price = _priceController.text;
                    final String description = _descriptionController.text;
                    final String location = _locationController.text;
                    final String imageUrl = _imageController.text;

                    if (title != null && price != null && description != null &&
                        location != null) {
                      Festival festival = Festival(
                          title, description, location, double.parse(price),imageUrl);
                        // Persist a new product to Firestore
                        var url = 'http://192.168.1.53:8080/events/add';
                        var response = await http.post(
                          url,
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'title': festival.title,
                            'description': festival.description,
                            'price':_priceController.text,
                            'location':festival.location,
                            'imageUrl':festival.imageUrl
                          }),
                        );
                        setState(() {
                          isFetched=false;
                        });
                      // If the server did return a 201 CREATED response,
                      }

                    // if (action == 'update') {
                    //   // Update the product
                    //   await _festivals
                    //       .doc(documentSnapshot!.id)
                    //       .update({"title": title, "price": price});
                    // }

                    // Clear the text fields
                    _titleController.text = '';
                    _priceController.text = '';
                    _imageController.text = '';
                    _locationController.text = '';
                    _descriptionController.text = '';

                    // Hide the bottom sheet
                    Navigator.of(context).pop();

                    //INFO ABOUT WHAT HAPPENED
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('You have successfully created a festival')));
                  },
                )
              ],
            ),
          );
        });
  }



  //Deleteing a festival by id
  Future<void> _deleteProduct(String productId) async {
    var url ='http://192.168.1.53:8080/events/delete/$productId';
    var response = await http.delete(url);
    setState(() {
      isFetched = false;
    });

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a festival')));
  }

  @override
  Widget build(BuildContext context) {
    if(isFetched==false)
      {
        fetchFestivals().then((value) {
          setState(() {
            _festivals.addAll(value);
            isFetched = true;
          });
        });
      }




    var size = _festivals.length;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createFestival(),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('All Festivals',textAlign: TextAlign.center,),
        actions: [
          Padding(padding: EdgeInsets.all(5),child: Image.asset('assets/images/logo.png')),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 100,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.scaleDown)
                  ),
                  child: Text(""),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Festivals'),
                onTap: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> const HomePage()));
                },
              ),
              if(roleUser=="ADMIN")
              ListTile(
                leading: const Icon(
                  Icons.train,
                ),
                title:   const Text('Applications'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> const AllApplications()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.info,
                ),
                title: const Text('Competitions'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> const HomePage()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.info,
                ),
                title: const Text('About'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> const AboutScreen()));
                },
              ),
              Text("-----------------------------------------------------------------------------"),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                ),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> const SettingsScreen()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text('Log Out'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> const LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),

      body: ListView.builder(
                itemCount: _festivals.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Card(
                      semanticContainer: true,
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: [
                              Image.network(_festivals[index].imageUrl,
                              height: 200,
                              width: 350,
                              fit: BoxFit.fill,
                              )],
                          ),
                          ListTile(
                            title: Text(_festivals[index].title),
                            subtitle: Text(_festivals[index].description),

                            trailing: SizedBox(
                              width: 170,
                              child: Row(
                                children: [
                                  if(roleUser == "ADMIN")
                                  // Press this button to edit a single product
                                  IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () =>{}
                                          ),
                                  // This icon button is used to delete a single product
                                  if(roleUser == "ADMIN")
                                  IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => _deleteProduct(_festivals[index].id.toString())),
                                  ElevatedButton(onPressed: ()=>{_createApplication(_festivals[index].id.toString())}, child: Text("Apply")),

                                ],
                              ),
                            ),
                          ),
                      ]),
                    ),
                  );
                },
              ),
         );
  }
}

