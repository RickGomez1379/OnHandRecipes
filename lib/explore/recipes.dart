// import 'package:flutter/material.dart';
// import 'package:onhandrecipes2/RecipesContent/Details.dart';
// import 'package:onhandrecipes2/RecipesContent/Recipe.dart';
// import 'package:onhandrecipes2/RecipesContent/recipecard.dart';
// import 'package:onhandrecipes2/RecipesContent/recipes.api.dart';

// class Recipes extends StatefulWidget {
//   const Recipes({super.key});

//   @override
//   RecipesState createState() => RecipesState();
// }

// class RecipesState extends State<Recipes> {
//   //List for Recipes
//   List<Recipe> recipes = [];

//   //For waiting on getRecipe
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     getRecipe();
//   }

//   Future<void> getRecipe() async {
//     recipes = await RecipesAPI.getRecipe(0, 20, "");
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               itemCount: recipes.length,
//               itemBuilder: (context, index) {
//                 if (double.tryParse(recipes[index].rating.toString()) == null) {
//                   return InkWell(
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => Details(recipe: recipes[index]))),
//                     child: RecipeCard(
//                         title: recipes[index].name,
//                         cardServings: recipes[index].serving,
//                         cardRating: "no rating",
//                         cardImage: recipes[index].image),
//                   );
//                 } else {
//                   return InkWell(
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => Details(recipe: recipes[index]))),
//                     child: RecipeCard(
//                         title: recipes[index].name,
//                         cardServings: recipes[index].serving,
//                         cardRating: recipes[index].rating * 100,
//                         cardImage: recipes[index].image),
//                   );
//                 }
//               }),
//     );
//   }
// }
