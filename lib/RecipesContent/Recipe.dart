// ignore_for_file: file_names

class Recipe {
  //Recipe variables
  final String name;
  final String? image;
  final double? rating;
  final int serving;
  final List<String> instructions;
  final List<String> ingredients;

//Recipe Constructor
  Recipe(
      {required this.name,
      required this.image,
      this.rating,
      required this.serving,
      required this.instructions,
      required this.ingredients});

//Recipe Factory Constructor
  factory Recipe.fromJson(dynamic json) {
    List<String> instructionsJson = [];
    List<String> ingredientsJson = [];

    for (var i in json["instructions"]) {
      instructionsJson.add(i["display_text"]);
    }
    for (var i in json["sections"]) {
      for (var j in i["components"]) {
        ingredientsJson.add(j["ingredient"]["name"]);
      }
    }
    if (double.tryParse((json['user_ratings']['score']).toString()) == null) {
      return Recipe(
          name: json["name"],
          image: json["thumbnail_url"],
          rating: 1.0,
          serving: json["num_servings"],
          instructions: instructionsJson,
          ingredients: ingredientsJson);
    } else {
      return Recipe(
          name: json["name"],
          image: json["thumbnail_url"],
          rating: double.parse(json['user_ratings']['score'].toString()),
          serving: json["num_servings"],
          instructions: instructionsJson,
          ingredients: ingredientsJson);
    }
  }
  //Returns List from API Snapshot
  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }
}
