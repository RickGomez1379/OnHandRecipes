import 'package:flutter/material.dart';
import 'package:onhandrecipes2/Create/CreateRecipes.dart';
import 'package:onhandrecipes2/RecipesContent/Details.dart';
import 'package:onhandrecipes2/explore.dart';

import '../RecipesContent/Recipe.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});
  @override
  Widget build(BuildContext context) {
    // //RecipeDetails Test
    // Recipe recipe = Recipe(
    //     name: "My Recipe",
    //     image:
    //         'https://img.freepik.com/free-vector/recipe-book-concept-illustration_114360-7481.jpg?size=626&ext=jpg&ga=GA1.2.1930064736.1678329442&semt=sph',
    //     rating: .71,
    //     serving: 5,
    //     instructions: ["instructions", "test"]);
    //Create Card Variables
    const createText = "Create Recipes";
    const createSubText = "Create Your Own Recipes";
    const createUrl =
        'https://img.freepik.com/free-vector/recipe-book-concept-illustration_114360-7481.jpg?size=626&ext=jpg&ga=GA1.2.1930064736.1678329442&semt=sph';

    //Explore Card Variables
    const exploreURL =
        'https://img.freepik.com/free-vector/illustration-drawing-style-food-collection_53876-44116.jpg?size=338&ext=jpg&ga=GA1.2.1930064736.1678329442&semt=ais';
    const exploreText = "Explore Recipes";
    const exploreSubtext = "Explore All Recipes OnHandRecipes Provides";

    //Ingredients Card Variables
    const ingredientsText = "On Hand Recipes";
    const ingredientsSubtext = "Cook Recipes By Using What's In Your Inventory";
    const ingredientsURL =
        'https://img.freepik.com/free-vector/refrigerator-with-lots-food_1308-98464.jpg?size=626&ext=jpg&ga=GA1.1.1930064736.1678329442&semt=sph';

    //Favorite Card Variables
    const favoriteText = "Favorite Recipes";
    const favoriteSubtext = "All Your Favorite Recipes";
    const favoriteURL =
        'https://img.freepik.com/free-vector/set-healthy-dishes_1308-28386.jpg?size=626&ext=jpg&ga=GA1.2.1930064736.1678329442&semt=ais';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 228, 250),

      //Displays Navigation Cards
      body: ListView(padding: const EdgeInsets.all(24), children: [
        //Navigate to
        //Explore Card
        Hero(
          tag: 'explore',
          child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Explore())),
              child: containCard(exploreText, exploreSubtext, exploreURL)),
        ),

        const SizedBox(
          height: 8,
        ),

        //Create Card
        Hero(
            tag: 'create',
            child: GestureDetector(
              child: containCard(createText, createSubText, createUrl),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CreateRecipes())),
            )),

        const SizedBox(
          height: 8,
        ),

        //Ingredients Card
        containCard(ingredientsText, ingredientsSubtext, ingredientsURL),

        const SizedBox(
          height: 8,
        ),

        //Favorite Card
        containCard(favoriteText, favoriteSubtext, favoriteURL),
      ]),
    );
  }

  //Creates single Navigation Card
  Container containCard(String text, String subtext, String url) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1), BlendMode.darken))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            subtext,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
