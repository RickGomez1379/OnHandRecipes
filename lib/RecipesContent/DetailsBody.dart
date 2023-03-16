import 'Recipe.dart';
import 'package:flutter/material.dart';

class DetailBody extends StatelessWidget {
  final Recipe recipe;

  const DetailBody({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                //Recipe Image
                DisplayRecipeImage(context),

                //Details: Instructions, Ingredients, Serving Size(Nutrition Facts perhaps)
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: 20.0,
                    right: 20.0,
                  ),
                  height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                ),
                // ProductTitleWithImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container DisplayRecipeImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 240,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: NetworkImage(recipe.image), fit: BoxFit.cover)),
    );
  }
}
