
// controllers/cashier_controller.dart
import 'package:sqflite/sqflite.dart' as sqflite;
import '../models/user_model.dart';
import '../database/db_helper.dart';

class CashierController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> createCashier(User cashier) async {
    final sqflite.Database db = await _dbHelper.database;
    await db.insert('users', cashier.toMap());
  }

  Future<User?> getCashierById(String id) async {
    final sqflite.Database db = await _dbHelper.database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  Future<List<User>> getAllCashiers() async {
    final sqflite.Database db = await _dbHelper.database;
    final result = await db.query('users', where: 'role = ?', whereArgs: ['cashier']);
    return result.map((map) => User.fromMap(map)).toList();
  }

  Future<void> updateCashier(User cashier) async {
    final sqflite.Database db = await _dbHelper.database;
    await db.update('users', cashier.toMap(), where: 'id = ?', whereArgs: [cashier.id]);
  }

  Future<void> deleteCashier(String id) async {
    final sqflite.Database db = await _dbHelper.database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}