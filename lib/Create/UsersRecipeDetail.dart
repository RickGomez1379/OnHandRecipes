import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onhandrecipes2/Create/EditUserRecipe.dart';
import 'RecipeDatabase.dart';
import 'UsersRecipe.dart';

class UsersRecipeDetail extends StatefulWidget {
  final int recipeId;

  const UsersRecipeDetail({
    Key? key,
    required this.recipeId,
  }) : super(key: key);

  @override
  _UsersRecipeDetailState createState() => _UsersRecipeDetailState();
}

class _UsersRecipeDetailState extends State<UsersRecipeDetail> {
  late UserRecipe recipe;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshRecipe();
  }

  Future refreshRecipe() async {
    setState(() => isLoading = true);

    recipe = await RecipeDatabase.instance.readRecipe(widget.recipeId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Row(children: <Widget>[
                      Text(
                        '${recipe.id}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        recipe.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(recipe.timeCreated),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${recipe.serving} Servings',
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipe.ingredients,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipe.instructions,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  //Navigates to EditRecipe Screen, Edit Existing Object
  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditUserRecipe(recipe: recipe),
        ));

        refreshRecipe();
      });

  //Deletes Recipe
  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await RecipeDatabase.instance.delete(widget.recipeId);

          Navigator.of(context).pop();
        },
      );
}
