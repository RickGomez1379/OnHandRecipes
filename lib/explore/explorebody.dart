import 'package:flutter/material.dart';
import 'package:onhandrecipes2/explore/category.dart';
import 'package:onhandrecipes2/explore/recipes.dart';

class ExploreBody extends StatelessWidget {
  const ExploreBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: const <Widget>[Category(), Recipes()]);
  }
}
