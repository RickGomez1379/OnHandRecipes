import 'dart:convert';
import 'Recipe.dart';
import 'package:http/http.dart' as http;

class RecipesAPI {
//Future Function to Retrieve Recipe Data from API
  static Future<List<Recipe>> getRecipe(int from, int to) async {
    //Location of API
    var uri = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": "$from", "size": "$to"});
    final response = await http.get(uri, headers: {
      "X-RapidAPI-Key": "714e5c5b83msh458404d4031277ap12d552jsnfa50a75540a3",
      "X-RapidAPI-Host": "tasty.p.rapidapi.com"
    });

    //Decodes data
    Map data = jsonDecode(response.body);

    //List for Recipes
    List recipes = [];

    //Populates List of Recipes
    for (var i in data['results']) {
      if (i['recipes'] == null) {
        recipes.add(i);
      }
    }
    //Returns Recipe List
    return Recipe.recipesFromSnapshot(recipes);
  }
}
