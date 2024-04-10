import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'IncomeExpense.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'BudgetPlanner.db');
    return await openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IncomeExpense(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          value REAL,
          isIncome INTEGER
        )
      ''');
      await db.execute('''
        CREATE TABLE TaskManagement(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          isChecked INTEGER 
        )
      ''');
      await db.execute('''
        CREATE TABLE SavingPlan(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          plan REAL,
          moneySpent REAL
        )
      ''');
    }, version: 1);
  }
  Future<void> insertValue(String table,Map<String,Object?> values) async {
    final Database db = await DatabaseHelper.database;
    await db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getIncomes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'IncomeExpense',
      where: 'isIncome = ?',
      whereArgs: [1],
    );
    return maps;

  }

  Future<List<Map<String, dynamic>>> getExpenses() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'IncomeExpense',
      where: 'isIncome = ?',
      whereArgs: [0],
    );
    return maps;

  }

  Future< List<Map<String,dynamic>>> getTasks() async{
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'TaskManagement',

    );
    return maps;
  }

  Future< List<Map<String,dynamic>>> getPlans() async{
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'SavingPlan',

    );
    return maps;
  }

  Future<int> delete(String table,int id) async {
    final Database db = await database;
    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateById(String table, int id, Map<String,dynamic> content) async {
    final Database db = await database;
    return await db.update(
      table,
     content,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<List<Map<String,dynamic>>>> getAllData() async{
    List<List<Map<String,dynamic>>> result = [];
    List<Map<String,dynamic>> incomes = await getIncomes();
    List<Map<String,dynamic>> expenses = await getExpenses();
    List<Map<String,dynamic>> plans = await getPlans();
    List<Map<String,dynamic>> tasks = await getTasks();
    result.addAll([incomes,expenses,tasks,plans]);
    return result;
  }
}

