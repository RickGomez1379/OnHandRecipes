import 'package:flutter/material.dart';
import 'package:onhandrecipes2/home/homebody.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'On Hand Recipes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeBody(),
    );
  }
}
