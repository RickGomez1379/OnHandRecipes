import 'package:flutter/material.dart';
import 'UsersRecipe.dart';
import 'RecipeDatabase.dart';
import 'RecipeForm.dart';

class EditUserRecipe extends StatefulWidget {
  final UserRecipe? recipe;

  const EditUserRecipe({
    Key? key,
    this.recipe,
  }) : super(key: key);
  @override
  EditUserRecipeState createState() => EditUserRecipeState();
}

class EditUserRecipeState extends State<EditUserRecipe> {
  final _formKey = GlobalKey<FormState>();
  late int servingEdit;
  late String name;
  late String instructionsEdit;
  late String ingredientsEdit;

  @override
  void initState() {
    super.initState();

    servingEdit = widget.recipe?.serving ?? 0;
    name = widget.recipe?.name ?? '';
    instructionsEdit = widget.recipe?.instructions ?? '';
    ingredientsEdit = widget.recipe?.ingredients ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: RecipeForm(
            serving: servingEdit,
            title: name,
            instructions: instructionsEdit,
            ingredients: ingredientsEdit,
            onChangedServing: (serving) =>
                setState(() => servingEdit = serving),
            onChangedName: (name) => setState(() => this.name = name),
            onChangedInstructions: (instruction) =>
                setState(() => instructionsEdit = instruction),
            onChangedIngredients: (ingredient) =>
                setState(() => ingredientsEdit = ingredient),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = name.isNotEmpty && instructionsEdit.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateRecipe,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateRecipe() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.recipe != null;

      if (isUpdating) {
        await updateRecipe();
      } else {
        await addRecipe();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateRecipe() async {
    final note = widget.recipe!.copy(
      serving: servingEdit,
      name: name,
      image: instructionsEdit,
    );

    await RecipeDatabase.instance.update(note);
  }

  Future addRecipe() async {
    final recipe = UserRecipe(
      name: name,
      serving: servingEdit,
      image:
          'https://media.istockphoto.com/id/618446308/vector/recipe-card.jpg?s=612x612&w=0&k=20&c=egib8N-ZFVW7-oUn9ikqynf9MZctvhrg5wdwp4ucP_E=',
      instructions: instructionsEdit,
      ingredients: ingredientsEdit,
      timeCreated: DateTime.now(),
    );

    await RecipeDatabase.instance.create(recipe);
  }
}
