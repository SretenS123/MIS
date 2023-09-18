
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyButton extends StatelessWidget{
  final String name;
  Function function;

  MyButton({
    required this.name,
    required this.function
});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(width: 300,height: 50,
      child: ElevatedButton(onPressed: (){ function();},
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              backgroundColor: Colors.grey,
              fontSize: 20,
            ),
          )),
    );
  }


}