class Recipe {
  //Recipe variables
  final String name;
  final String image;
  final rating;
  final int serving;
  final List<String> instructions;

//Recipe Constructor
  Recipe(
      {required this.name,
      required this.image,
      required this.rating,
      required this.serving,
      required this.instructions});

//Recipe Factory Constructor
  factory Recipe.fromJson(dynamic json) {
    List<String> instructionsJson = [];
    for (var i in json["instructions"]) {
      instructionsJson.add(i["display_text"]);
    }
    return Recipe(
        name: json["name"] as String,
        image: json["thumbnail_url"] as String,
        rating: json["user_ratings"]['score'] ?? "no rating",
        serving: json["num_servings"] as int,
        instructions: instructionsJson);
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
