import 'package:flutter/material.dart';
import 'package:onhandrecipes2/RecipesContent/DetailsBody.dart';

import 'Recipe.dart';

class Details extends StatelessWidget {
  final Recipe recipe;

  const Details({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailAppBar(context),
      body: DetailBody(recipe: recipe),
    );
  }

  AppBar detailAppBar(BuildContext context) {
    return AppBar(
      title: Text(recipe.name),
      leading: IconButton(
        //Back Arrow
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.yellow,
          size: 18,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        //Favorite Icon
        //TODO: Change Opacity if in Favorite
        IconButton(
          icon: const Icon(
            Icons.star,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
