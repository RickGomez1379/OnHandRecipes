import 'package:flutter/material.dart';
import 'package:onhandrecipes2/RecipesContent/Recipe.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  void toggleFavorite(Recipe recipe) {
    final isExist = _recipes.contains(recipe);
    if (isExist) {
      _recipes.remove(recipe);
    } else {
      _recipes.add(recipe);
    }
    notifyListeners();
  }

  bool isExist(Recipe recipe) {
    final isExist = _recipes.contains(recipe);
    return isExist;
  }

  void clearFavorite() {
    _recipes = [];
    notifyListeners();
  }

  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
