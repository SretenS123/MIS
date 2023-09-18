import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About World Festival Association'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Text(
                'Welcome to World Festival Association',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'We Celebrate the Rich Tapestry of Culture',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'At the World Festival Association, our mission is to bring the world together through the joy of festivals. We focus on three main pillars:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              Text(
                '1. Folklore Festivals: Experience the magic of age-old traditions, music, and dances from around the world.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '2. Majorettes Performances: Witness the elegance and precision of majorettes as they dazzle with their skills.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '3. Orchestras: Immerse yourself in the symphonic beauty of orchestral performances, blending classical and contemporary music.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Join us on this cultural journey, where diversity thrives, artists shine, and unity prevails.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Contact Us:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email: contact@worldfestivalassociation.com'),
                onTap: () {
                  // Implement email functionality here
                },
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Phone: +1 (123) 456-7890'),
                onTap: () {
                  // Implement phone call functionality here
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Connect with Us on Social Media:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.facebook),
                    onPressed: () {
                      // Implement Facebook link here
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.safety_check),
                    onPressed: () {
                      // Implement Twitter link here
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.whatshot_outlined),
                    onPressed: () {
                      // Implement Instagram link here
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
