import 'dart:ffi';

class Festival {
  late int id;
   late String title;
   late String description;
  late double price;
   late String location;
   late String imageUrl;



  Festival(this.title, this.description, this.location, this.price,this.imageUrl);

  Festival.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    location = json['location'];
    price = json['price'];
    imageUrl = json['imageUrl'];

  }

}