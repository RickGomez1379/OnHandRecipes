import 'package:flutter/material.dart';
import 'package:onhandrecipes2/explore/explorebody.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  ExploreState createState() => ExploreState();
}

class ExploreState extends State<Explore> {
  @override
  Widget build(Object context) {
    return const ExploreBody();
  }
}
