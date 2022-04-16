import 'package:dio/dio.dart';
import 'package:flutter_coffee_app/helper/static_variable.dart';

Future<List<dynamic>> getMenuByCategory(int id) async {
  List<dynamic> _results = [];
  String url = '$HostAddress/menu/category/$id';
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

Future<Map<String, dynamic>> getMenyById(int id) async {
  Map<String, dynamic> _data = {};
  String url = '$HostAddress/menu/detail/$id';
  try {
    final response = await Dio().get(
      url,
      options: Options(
        headers: {"Accept": "application/json"},
      ),
    );
    _data = response.data["payload"] as Map<String, dynamic>;
    print("Oke");
  } on DioError catch (e) {
    print(e.message);
  }
  return _data;
}
