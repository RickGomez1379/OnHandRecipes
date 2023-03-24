import 'package:flutter/material.dart';
import 'package:onhandrecipes2/explore/category.dart';
import 'package:onhandrecipes2/explore/recipes.dart';

class ExploreBody extends StatelessWidget {
  const ExploreBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Recipes"),
        leading: IconButton(
          //Back Arrow
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.yellow,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Category(),
    );
  }
}
