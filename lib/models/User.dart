

import 'dart:ffi';

class User{
  late int id;

  late String firstName;

  late String lastName;

  late String email;

  late String password;

  late  String role;


  User(this.id, this.firstName, this.lastName, this.email, this.password,
      this.role);

  User.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    role = json['role'];

  }
}