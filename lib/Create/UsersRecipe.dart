const String tableRecipes = 'recipes';

class RecipeFields {
  static final List<String> values = [
    /// Add all fields
    id, name, image, serving, instructions, ingredients, time
  ];
  static const String id = '_id';
  static const String name = 'name';
  static const String image = 'image';
  static const String serving = 'serving';
  static const String instructions = 'instructions';
  static const String ingredients = 'ingredients';
  static const String time = 'time';
}

class UserRecipe {
  //Recipe variables
  final int? id;
  final String name;
  final String? image;
  final int serving;
  final String instructions;
  final String ingredients;
  final DateTime timeCreated;

  UserRecipe(
      {this.id,
      required this.timeCreated,
      required this.name,
      this.image,
      required this.serving,
      required this.instructions,
      required this.ingredients});

//Returns Recipe From Database Json
  static UserRecipe fromDBJson(Map<String, Object?> json) => UserRecipe(
      id: json[RecipeFields.id] as int?,
      name: json[RecipeFields.name] as String,
      image: json[RecipeFields.image] as String?,
      serving: json[RecipeFields.serving] as int,
      instructions: json[RecipeFields.instructions] as String,
      ingredients: json[RecipeFields.ingredients] as String,
      timeCreated: DateTime.parse(json[RecipeFields.time] as String));

  //Returns Map by Converting Recipe to Json
  Map<String, Object?> toDBJson() => {
        RecipeFields.id: id,
        RecipeFields.name: name,
        RecipeFields.image: image,
        RecipeFields.serving: serving,
        RecipeFields.instructions: instructions,
        RecipeFields.ingredients: ingredients,
        RecipeFields.time: timeCreated.toIso8601String(),
      };

  //Copies Recipes, Change Values by using Parameters
  UserRecipe copy({
    int? id,
    String? name,
    String? image,
    int? serving,
    String? instructions,
    String? ingredients,
    DateTime? createdTime,
  }) =>
      UserRecipe(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        serving: serving ?? this.serving,
        instructions: instructions ?? this.instructions,
        ingredients: ingredients ?? this.ingredients,
        timeCreated: createdTime ?? timeCreated,
      );
}
