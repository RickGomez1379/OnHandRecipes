import 'package:flutter/material.dart';
import 'package:onhandrecipes2/RecipesContent/Details.dart';
import 'package:onhandrecipes2/RecipesContent/Recipe.dart';
import 'package:onhandrecipes2/RecipesContent/recipecard.dart';
import 'package:onhandrecipes2/RecipesContent/recipes.api.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends State<Category> {
  //List for Recipes
  List<Recipe> recipes = [];
  List<Recipe> all = [];
  List<Recipe> vegan = [];
  List<Recipe> mexican = [];
  List<Recipe> japanese = [];
  List<Recipe> american = [];

  //For waiting on getRecipe
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipe();
  }

  Future<void> getRecipe() async {
    recipes = await RecipesAPI.getRecipe(0, 20, 0);
    vegan = await RecipesAPI.getRecipe(0, 20, 1);
    mexican = await RecipesAPI.getRecipe(0, 20, 2);
    japanese = await RecipesAPI.getRecipe(0, 20, 3);
    american = await RecipesAPI.getRecipe(0, 20, 4);

    setState(() {
      all = recipes;
      isLoading = false;
    });
  }

  //List for horizontal ListView
  List<String> categories = ["All", "Vegan", "Mexican", "Japanese", "American"];
  //Index for ListView
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    //Horizontal Scroll View
    return Column(children: <Widget>[
      SizedBox(
        height: 25,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) => buildCategory(categories, index)),
      ),
      Recipe_Cards()
    ]);
  }

  // ignore: non_constant_identifier_names
  Expanded Recipe_Cards() {
    return Expanded(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                if (double.tryParse(recipes[index].rating.toString()) == null) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Details(recipe: recipes[index]))),
                    child: RecipeCard(
                        title: recipes[index].name,
                        cardServings: recipes[index].serving,
                        cardRating: "no rating",
                        cardImage: recipes[index].image),
                  );
                } else {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Details(recipe: recipes[index]))),
                    child: RecipeCard(
                        title: recipes[index].name,
                        cardServings: recipes[index].serving,
                        cardRating: recipes[index].rating * 100,
                        cardImage: recipes[index].image),
                  );
                }
              }),
    );
  }

  buildCategory(List<String> categories, int index) {
    return GestureDetector(
      //Update Selected Index
      onTap: () {
        setState(() {
          selectedIndex = index;
          if (selectedIndex == 0) {
            recipes = all;
          } else if (selectedIndex == 1) {
            recipes = vegan;
          } else if (selectedIndex == 2) {
            recipes = mexican;
          } else if (selectedIndex == 3) {
            recipes = japanese;
          } else if (selectedIndex == 4) {
            recipes = american;
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Displays All Categories
              Text(
                categories[index],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == index
                        ? const Color(0xFF535353)
                        : Colors.blue),
              ),
              //Displays the Category Chosen
              Container(
                margin: const EdgeInsets.only(top: 5),
                height: 2,
                width: 30,
                color:
                    selectedIndex == index ? Colors.black : Colors.transparent,
              )
            ]),
      ),
    );
  }
}
