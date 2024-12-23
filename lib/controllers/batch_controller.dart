import 'package:sqflite/sqflite.dart' as sqflite;
import '../models/batch_model.dart';
import '../database/db_helper.dart';

class BatchController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> createBatch(Batch batch) async {
    final sqflite.Database db = await _dbHelper.database;
    await db.insert('batches', batch.toMap());
  }

  Future<Batch?> getBatchById(String id) async {
    final sqflite.Database db = await _dbHelper.database;
    final result = await db.query('batches', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Batch.fromMap(result.first) : null;
  }

  Future<List<Batch>> getAllBatches() async {
    final sqflite.Database db = await _dbHelper.database;
    final result = await db.query('batches');
    return result.map((map) => Batch.fromMap(map)).toList();
  }

  Future<void> updateBatch(Batch batch) async {
    final sqflite.Database db = await _dbHelper.database;
    await db.update('batches', batch.toMap(), where: 'id = ?', whereArgs: [batch.id]);
  }

  Future<void> deleteBatch(String id) async {
    final sqflite.Database db = await _dbHelper.database;
    await db.delete('batches', where: 'id = ?', whereArgs: [id]);
  }
}
