import 'dart:convert';
import 'dart:developer';
import 'dart:developer' as dev;

import 'package:chin_chin/data/models/trivia_category.dart';
import 'package:chin_chin/data/models/trivia_question.dart';
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

  // https://opentdb.com/api.php?amount=10&category=20&difficulty=medium

  static Future<List<TriviaQuestion>> getQuestions(int amount, int? category, String difficulty) async {
    var questions = <TriviaQuestion>[];
    var URL = 'https://opentdb.com/api.php';

    URL += '?amount=$amount';

    if (category != null) {
      URL += '&category=$category';
    }

    if (!difficulty.contains('any')) {
      URL += '&difficulty=${difficulty.toLowerCase()}';
    }

    dev.log(URL);

    try {
      final response = await http
      .get(Uri.parse(URL));

      if (response.statusCode == 200) {
        for (var item in jsonDecode(response.body)['results']) {
          questions.add(TriviaQuestion.fromJson(item));
        }
        log(questions.toString());
      } else {
        throw Exception('Failed to Load Categoires');
      }
      
    } catch (e) {
      log(e.toString());
    }
    return questions;
  }
}