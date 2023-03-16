import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends State<Category> {
  //List for horizontal ListView
  List<String> categories = [
    "All",
    "Vegan",
    "Mexican",
    "Italian",
    "Indian",
    "Japanese",
    "Chinese",
    "British"
  ];
  //Index for ListView
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    //Horizontal Scroll View
    return SizedBox(
      height: 25,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(categories, index)),
    );
  }

  buildCategory(List<String> categories, int index) {
    return GestureDetector(
      //Update Selected Index
      onTap: () {
        setState(() {
          selectedIndex = index;
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
