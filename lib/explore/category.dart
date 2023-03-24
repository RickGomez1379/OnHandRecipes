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
  //List of Recipes with Categories
  List<List<Recipe>> list = [];
  //List for Recipes
  List<Recipe> recipes = [];
  Recipe filledRecipe = Recipe(
      name: "name",
      image: "image",
      rating: 1.0,
      serving: 0,
      instructions: [],
      ingredients: []);

  //For waiting on getRecipe
  bool isLoading = true;

  //List for horizontal ListView
  List<String> categories = ["All", "Vegan", "Mexican", "Japanese", "American"];
  //Index for ListView
  int selectedIndex = 0;

  //Fills List of Lists for Population by Index
  void fillList() {
    List<Recipe> filledList = [filledRecipe];
    list = [filledList, filledList, filledList, filledList, filledList];
  }

//Creates Recipes Once
  @override
  void initState() {
    super.initState();
    fillList();
    getRecipes();
  }

  //Populates List in Background
  Future<void> getRecipes() async {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(milliseconds: 500), () async {
        list[i] = await RecipesAPI.getRecipe(0, 20, i);
        if (isLoading == true) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  //Manually Sets Recipes in List at Selected Index
  Future<void> checkRecipe() async {
    if (list[selectedIndex][0] == filledRecipe) {
      setState(() {
        if (isLoading == false) {
          isLoading = true;
        }
      });
      await Future.delayed(const Duration(milliseconds: 500), () async {
        list[selectedIndex] = await RecipesAPI.getRecipe(0, 20, selectedIndex);
      });
      setState(() {
        if (isLoading == true) {
          isLoading = false;
        }
      });
    } else {
      return;
    }
  }

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
      recipeCards()
    ]);
  }

  Expanded recipeCards() {
    return Expanded(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: list[selectedIndex].length,
              itemBuilder: (context, index) {
                if (double.tryParse(
                        list[selectedIndex][index].rating.toString()) ==
                    null) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            Details(recipe: list[selectedIndex][index]))),
                    child: Hero(
                      tag: '$index',
                      child: RecipeCard(
                          title: list[selectedIndex][index].name,
                          cardServings: list[selectedIndex][index].serving,
                          cardRating: "no rating",
                          cardImage: list[selectedIndex][index].image),
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            Details(recipe: list[selectedIndex][index]))),
                    child: Hero(
                      tag: '$index',
                      child: RecipeCard(
                          title: list[selectedIndex][index].name,
                          cardServings: list[selectedIndex][index].serving,
                          cardRating: list[selectedIndex][index].rating! * 100,
                          cardImage: list[selectedIndex][index].image),
                    ),
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
          checkRecipe();
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
