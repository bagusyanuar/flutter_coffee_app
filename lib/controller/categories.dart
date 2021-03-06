import 'package:dio/dio.dart';
import 'package:flutter_coffee_app/helper/static_variable.dart';

Future<List<dynamic>> listCategories() async {
  List<dynamic> _results = [];
  String url = '$HostAddress/categories';
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

