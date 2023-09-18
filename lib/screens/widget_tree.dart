
import 'package:domasna_mis_193008/screens/home.dart';

import 'login_register.dart';
import 'package:domasna_mis_193008/auth.dart';
import 'package:flutter/cupertino.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder (
    // stream: Auth().authStateChanges,
      builder: (BuildContext context,  snapshot) {
        // if (snapshot.hasData)
          return LoginScreen();
        // else
        //   return const LoginScreen();
      }
    );
  }
}
