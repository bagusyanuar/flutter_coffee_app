import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/view/dashboard.dart';
import 'package:flutter_coffee_app/view/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        'dashboard': (context) => Dashboard()
      },
    );
  }
}
