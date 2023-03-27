import 'package:flutter/material.dart';

class RecipeForm extends StatelessWidget {
  final int? serving;
  final String? title;
  final String? instructions;
  final String? ingredients;

  final ValueChanged<int> onChangedServing;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedInstructions;
  final ValueChanged<String> onChangedIngredients;

  const RecipeForm(
      {Key? key,
      this.serving = 0,
      this.title = '',
      this.instructions = '',
      this.ingredients = '',
      required this.onChangedServing,
      required this.onChangedName,
      required this.onChangedInstructions,
      required this.onChangedIngredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "$serving",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Slider(
                      value: (serving ?? 0).toDouble(),
                      min: 0,
                      max: 10,
                      divisions: 10,
                      onChanged: (number) => onChangedServing(number.toInt()),
                    ),
                  )
                ],
              ),
              buildTitle(),
              const SizedBox(height: 8),
              buildInstructions(),
              const SizedBox(height: 16),
              buildIngreients()
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Recipe Name',
          hintStyle: TextStyle(color: Colors.black45),
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedName,
      );

  Widget buildInstructions() => TextFormField(
        maxLines: 5,
        initialValue: instructions,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type instructions',
          hintStyle: TextStyle(color: Colors.black45),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The instructions cannot be empty'
            : null,
        onChanged: onChangedInstructions,
      );
  Widget buildIngreients() => TextFormField(
        maxLines: 5,
        initialValue: ingredients,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type Ingredients',
          hintStyle: TextStyle(color: Colors.black45),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The ingredients cannot be empty'
            : null,
        onChanged: onChangedIngredients,
      );
}
