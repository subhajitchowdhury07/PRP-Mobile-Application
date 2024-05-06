import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../ui/screens/after_login_screen.dart'; // Import the AfterLoginScreen widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AfterLoginScreen(), // Set the AfterLoginScreen as the home screen
    );
  }
}
