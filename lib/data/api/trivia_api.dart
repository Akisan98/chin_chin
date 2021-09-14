import 'dart:convert';
import 'dart:developer';

import 'package:chin_chin/data/models/trivia_category.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


/// Class for seperating API logic / code from UI
class TriviaAPI {

  /// HTTPS Client for Web Request
  Client client = Client();

  static Future<List<TriviaCategory>> getCategories() async {
    var categories = <TriviaCategory>[];

    try {
      final response = await http
      .get(Uri.parse('https://opentdb.com/api_category.php'));

      if (response.statusCode == 200) {
        for (var item in jsonDecode(response.body)['trivia_categories']) {
          categories.add(TriviaCategory.fromJson(item));
        }
        log(categories.toString());
      } else {
        throw Exception('Failed to Load Categoires');
      }
      
    } catch (e) {
      log(e.toString());
    }
    return categories;
  }

}