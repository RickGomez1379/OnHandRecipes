class Recipe {
  //Recipe variables
  final String name;
  final String image;
  final rating;
  final int serving;
  final List<String> instructions;
  final List<String> ingredients;

//Recipe Constructor
  Recipe(
      {required this.name,
      required this.image,
      required this.rating,
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
    return Recipe(
        name: json["name"] as String,
        image: json["thumbnail_url"] as String,
        rating: json["user_ratings"]['score'] ?? "no rating",
        serving: json["num_servings"] as int,
        instructions: instructionsJson,
        ingredients: ingredientsJson);
  }
  //Returns List from API Snapshot
  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  //Test Results Output
  // @override
  // String toString() {
  //   return 'Recipe {name: $name, image: $image, rating: $rating, servings: $serving }';
  // }
}
