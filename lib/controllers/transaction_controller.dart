import 'package:sqflite/sqflite.dart' as sqflite;
import '../models/transaction_model.dart';
import '../database/db_helper.dart';

class TransactionController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> createTransaction(Transaction transaction) async {
    final sqflite.Database db = await _dbHelper.database;
    await db.insert('transactions', transaction.toMap());
  }

  Future<Transaction?> getTransactionById(String id) async {
    final sqflite.Database db = await _dbHelper.database;
    final result = await db.query('transactions', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Transaction.fromMap(result.first) : null;
  }

  Future<List<Transaction>> getAllTransactions() async {
    final sqflite.Database db = await _dbHelper.database;
    final result = await db.query('transactions');
    return result.map((map) => Transaction.fromMap(map)).toList();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    final sqflite.Database db = await _dbHelper.database;
    await db.update('transactions', transaction.toMap(), where: 'id = ?', whereArgs: [transaction.id]);
  }

  Future<void> deleteTransaction(String id) async {
    final sqflite.Database db = await _dbHelper.database;
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}
