import 'dart:convert';
import 'Recipe.dart';
import 'package:http/http.dart' as http;

class RecipesAPI {
//Future Function to Retrieve Recipe Data from API
  static Future<List<Recipe>> getRecipe(int from, int to, int index) async {
    //List for Recipes
    List recipesData = [];

    //API header
    var header = {
      'X-RapidAPI-Key': '3b2b2af678msh906e0026b70087dp10733djsn872a1320bb60',
      'X-RapidAPI-Host': 'tasty.p.rapidapi.com'
    };

    //Location of APIs <Different Categories
    //All Recipes no Tags
    var uriAll = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": "$from", "size": "$to"});

    //Vegan Recipes
    var uriVegan = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": "$from", "size": "$to", "tags": "vegan"});

    //Mexican Recipes
    var uriMexican = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": "$from", "size": "$to", "tags": "mexican"});

    //Japanese Recipes
    var uriJapanese = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": "$from", "size": "$to", "tags": "japanese"});
    //American Recipes
    var uriAmerican = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": "$from", "size": "$to", "tags": "american"});

    final response = await Future.wait([
      http.get(uriAll, headers: header),
      http.get(uriVegan, headers: header),
      http.get(uriMexican, headers: header),
      http.get(uriJapanese, headers: header),
      http.get(uriAmerican, headers: header),
    ]);

    //Decodes data
    Map data;
    if (index == 0) {
      data = jsonDecode(response[0].body);
    } else if (index == 1) {
      data = jsonDecode(response[1].body);
    } else if (index == 2) {
      data = jsonDecode(response[2].body);
    } else if (index == 3) {
      data = jsonDecode(response[3].body);
    } else {
      data = jsonDecode(response[4].body);
    }

    //Populates List of Recipes
    for (var i in data['results']) {
      if (i['recipes'] == null) {
        recipesData.add(i);
      }
    }
    //Returns Recipe List
    return Recipe.recipesFromSnapshot(recipesData);
  }
}
