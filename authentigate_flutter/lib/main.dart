import 'package:flutter/material.dart';
import 'package:authentigate_flutter/screens/register_screen.dart';
import 'package:authentigate_flutter/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthentiGate',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Set the initial route to the Login Page
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
