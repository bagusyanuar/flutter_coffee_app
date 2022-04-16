import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_coffee_app/helper/static_variable.dart';

typedef FunctionStringCallback = Function(String params);
void addToCart(Map<String, dynamic> data, FunctionStringCallback onSuccess,
    FunctionStringCallback onFailure) async {
  try {
    var formData = FormData.fromMap(data);
    final response = await Dio().post("$HostAddress/cart",
        options: Options(headers: {"Accept": "application/json"}),
        data: formData);
    final int status = response.data["status"] as int;
    final String message = response.data["message"] as String;
    if (status == 200) {
      onSuccess(message);
    } else {
      onFailure(message);
    }
    print(response.data.toString());
  } on DioError catch (e) {
    print(e.response);
  }
}

Future<List<dynamic>> listAvailableCart() async {
  List<dynamic> _results = [];
  String url = '$HostAddress/cart';
  try {
    final response = await Dio().get(
      url,
      options: Options(
        headers: {"Accept": "application/json"},
      ),
    );
    _results = response.data["payload"] as List;
    print("Oke");
  } on DioError catch (e) {
    print(e.message);
  }
  return _results;
}
