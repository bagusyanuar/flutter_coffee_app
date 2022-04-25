import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSplash();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo.png"),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Text(
                    "Smart Cafe App",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text("Yudha \u00a9 2022"),
            ),
          )
        ],
      ),
    );
  }

  void _initSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Navigator.popAndPushNamed(context, "/login");
    if (token != null) {
    } else {
      
    }
  }
}
