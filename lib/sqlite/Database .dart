import 'dart:async';
import 'dart:io';

import 'package:firestoreapp/sqlite/FoodModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "FoodDB.db");
    return await openDatabase(path, version: 4, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Food ("
          "id INTEGER PRIMARY KEY,"
          "food_name TEXT,"
          "price INTEGER,"
          "total INTEGER"
          ")");
    });
  }

  newFood(Food newFood) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Food");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Food (id,food_name,price,total)"
        " VALUES (?,?,?,?)",
        [id, newFood.foodName, newFood.price, newFood.total]);
    return raw;
  }

  blockOrUnblock(Food client) async {
    final db = await database;
    Food blocked = Food(
      id: client.id,
      foodName: client.foodName,
      price: client.price,
      total: client.total,
    );
    var res = await db.update("Food", blocked.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateFood(Food newClient) async {
    final db = await database;
    var res = await db.update("Food", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  getFood(int id) async {
    final db = await database;
    var res = await db.query("Food", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Food.fromMap(res.first) : null;
  }


  Future<List<Food>> getAllFoods() async {
    final db = await database;
    var res = await db.query("Food");
    List<Food> list =
        res.isNotEmpty ? res.map((c) => Food.fromMap(c)).toList() : [];
    return list;
  }

  deleteFood(int id) async {
    final db = await database;
    return db.delete("Food", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete from Food");
  }
}
