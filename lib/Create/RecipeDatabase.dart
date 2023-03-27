import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'UsersRecipe.dart';

class RecipeDatabase {
  static final RecipeDatabase instance = RecipeDatabase.init();
  static Database? _database;

  RecipeDatabase.init();

  //Returns Existing Database else return new Database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB('recipes.db');
    return _database!;
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  //Creates Database
  Future createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableRecipes(
  ${RecipeFields.id} $idType,
  ${RecipeFields.name} $textType,
  ${RecipeFields.image} $textType,
  ${RecipeFields.serving} $intType,
  ${RecipeFields.instructions} $textType,
  ${RecipeFields.ingredients} $textType,
  ${RecipeFields.time} $textType
)
''');
  }

  //Creates a Recipe and Inserts it in Database
  Future<UserRecipe> create(UserRecipe recipe) async {
    final db = await instance.database;

    final id = await db.insert(tableRecipes, recipe.toDBJson());
    return recipe.copy(id: id);
  }

  //Reads a Recipe from id
  Future<UserRecipe> readRecipe(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRecipes,
      columns: RecipeFields.values,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserRecipe.fromDBJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //Reads All Recipes in the Database
  Future<List<UserRecipe>> readAllRecipes() async {
    final db = await instance.database;

    // const orderBy = '${RecipeFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableRecipes ORDER BY $orderBy');

    final result = await db.query(tableRecipes);

    return result.map((json) => UserRecipe.fromDBJson(json)).toList();
  }

  //Updates Recipe
  Future<int> update(UserRecipe recipe) async {
    final db = await instance.database;

    return db.update(
      tableRecipes,
      recipe.toDBJson(),
      where: '${RecipeFields.id} = ?',
      whereArgs: [recipe.id],
    );
  }

  //Deletes Recipe by id
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableRecipes,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );
  }

  //Closes Database
  Future closeDB() async {
    final db = await instance.database;
    db.close();
    _database = null;
  }
}
