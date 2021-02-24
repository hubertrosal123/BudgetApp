import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_budgetapp_final_sqflite_second');
    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute("CREATE TABLE categories(id INTEGER PRIMARY KEY, categoryName TEXT, budgetLimit DOUBLE)");
    await database.execute("CREATE TABLE items(itemID INTEGER PRIMARY KEY, itemName TEXT, amount DOUBLE, date TEXT, categoryID INTEGER)");
  }
}