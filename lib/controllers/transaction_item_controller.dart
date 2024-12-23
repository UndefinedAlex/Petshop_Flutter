import '../models/transaction_item_model.dart';
import '../database/db_helper.dart';

class TransactionItemController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> createTransactionItem(TransactionItem item) async {
    final db = await _dbHelper.database;
    await db.insert('transaction_items', item.toMap());
  }

  Future<List<TransactionItem>> getAllTransactionItems() async {
    final db = await _dbHelper.database;
    final result = await db.query('transaction_items');
    return result.map((map) => TransactionItem.fromMap(map)).toList();
  }

  Future<void> deleteTransactionItem(String id) async {
    final db = await _dbHelper.database;
    await db.delete('transaction_items', where: 'id = ?', whereArgs: [id]);
  }
}
