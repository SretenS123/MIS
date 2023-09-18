import 'dart:ffi';

class Application {
  late String fullName;
  late String phone;
  late String numberOfPeople;
  late String numberOfNights;
  late String transport;
  late String country;
  late String  userEmail;



  Application(this.fullName, this.phone, this.numberOfPeople,this.numberOfNights, this.transport,this.country,this.userEmail);

  Application.fromJson(Map<String,dynamic> json)
  {
    fullName = json['fullName'];
    phone = json['phone'];
    numberOfPeople = json['numberOfPeople'];
    numberOfNights = json['numberOfNights'];
    transport = json['transport'];
    country = json['country'];
    userEmail = json['userEmail'];

  }

}