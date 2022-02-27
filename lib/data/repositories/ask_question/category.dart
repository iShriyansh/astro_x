
import 'package:astro_tak/config/config.dart';
import 'package:dio/dio.dart';

import '../../models/categories.dart';

class CategoryAPI {
  Future<Categories> getCategories() async {
    const String url = baseUrl + '/question/category/all';
    var response = await Dio().get(url);

    try {
      if (response.statusCode == 200) {
        return Categories.fromJson(response.data);
      } else {
        throw Exception('Internal server error');
      }
    } on Exception catch (e) {
      print(e);
      throw Exception('Failed to load categories');
    }
  }
}
