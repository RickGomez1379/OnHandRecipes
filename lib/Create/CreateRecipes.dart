import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:onhandrecipes2/Create/UsersRecipeCard.dart';
import 'package:onhandrecipes2/Create/UsersRecipeDetail.dart';
import 'RecipeDatabase.dart';
import 'UsersRecipe.dart';
import 'EditUserRecipe.dart';
import 'package:onhandrecipes2/RecipesContent/Details.dart';

class CreateRecipes extends StatefulWidget {
  const CreateRecipes({super.key});

  @override
  _CreateRecipesState createState() => _CreateRecipesState();
}

class _CreateRecipesState extends State<CreateRecipes> {
  late List<UserRecipe> recipes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshRecipes();
  }

  @override
  void dispose() {
    RecipeDatabase.instance.closeDB();

    super.dispose();
  }

  Future refreshRecipes() async {
    setState(() => isLoading = true);

    recipes = await RecipeDatabase.instance.readAllRecipes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Recipes',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : recipes.isEmpty
                  ? const Text(
                      'No Recipes',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UsersRecipeDetail(
                                    recipeId: recipes[index].id!)));
                          },
                          child: UsersRecipeCard(
                              name: recipes[index].name,
                              image: recipes[index].image,
                              serving: recipes[index].serving),
                        );
                      },
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditUserRecipe()));

            refreshRecipes();
          },
        ),
      );
}
