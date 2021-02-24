import 'package:budget_app_final/repositories/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DatabaseConnection _databaseConnection;

  Repository() {
    //initialize db connection
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  //Checks if database exists or not
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  //Inserting data to table
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  //Read data from table jj 
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  //Read ID
  readDataWithID(table, categoryID) async {
    var connection = await database;
    return await connection.query(table, where: 'categoryID=?', whereArgs: [categoryID]);
  } 

  readDataByID(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'itemID=?', whereArgs: [itemId]);
  }

  //Delete data
  deleteData(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE itemID = $itemId");
  }

  //Update data from table
  updateData(table,data) async {
    var connection = await database;
    return await connection.update(table, data,where:'itemID=?', whereArgs: [data['itemID']]);
  }

}