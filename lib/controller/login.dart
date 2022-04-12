import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/helper/static_variable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void Login(Map<String, String> data, BuildContext context) async {
  try {
    var formData = FormData.fromMap(data);
    final response = await Dio().post("$HostAddress/login",
        options: Options(headers: {"Accept": "application/json"}),
        data: formData);
    final int status = response.data["status"] as int;
    final String message = response.data["msg"] as String;
    if (status == 200) {
      final Map<String, dynamic> payload =
          response.data["payload"] as Map<String, dynamic>;
      String token = payload["access_token"] as String;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("token", token);
      Fluttertoast.showToast(
        msg: "Login Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushNamedAndRemoveUntil(
          context, "/dashboard", ModalRoute.withName("/dashboard"));
      print("Login Success");
    } else {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print("Login Failed");
    }
  } on DioError catch (e) {
     Fluttertoast.showToast(
        msg: "Terjadi Kesalahan " + e.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    print("Login Failed " + e.response.toString());
  }
}
