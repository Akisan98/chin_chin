class TriviaCategories {
  TriviaCategories({required this.triviaCategories});

  late List<TriviaCategory> triviaCategories;

  TriviaCategories.fromJson(Map<String, dynamic> json) {
    if (json['trivia_categories'] != null) {
      triviaCategories = <TriviaCategory>[];
      
      json['trivia_categories'].forEach((v) {
        triviaCategories.add(TriviaCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (triviaCategories.isNotEmpty) {
      data['trivia_categories'] =
          triviaCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TriviaCategory {
  TriviaCategory({required this.id, required this.name});

  late int id;
  late String name;

  TriviaCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return 'TriviaCatagory: $name, ID: $id\n';
  }
}