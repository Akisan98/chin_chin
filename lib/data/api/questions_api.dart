import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

/// Class for seperating API logic / code from UI
class Questions {

  /// HTTPS Client for Web Request
  Client client = Client();

  /// Paths To Mock API
  static const _url = 'https://raw.githubusercontent.com/Akisan98/chin_chin/master/questions/';
  static const _filePath =  [
    'neverHaveI.json',
    'whoIs.json',
    'wouldYouRather.json',
    'truths.json',
    'dares.json'
  ];

  /// Method for Fetch and Converting API to Data Object
  static Future<List<String>> getQuestions(int id) async {
    var questions = <String>[];

    try {
      final response = await http
      .get(Uri.parse(_url + _filePath[id]));

      if (response.statusCode == 200) {
        for (var item in jsonDecode(response.body)['questions']) {
          questions.add(item);
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

  /// Spesific Method for Truth and Dare as it a Bit Differnet.
  static Future<List<List<String>>> getTruthAndDareQuestions() async {
    var truthQuestions = await getQuestions(3);
    var dareQuestions =  await getQuestions(4);

    return [truthQuestions, dareQuestions];
  }
}