import '../models/discount_model.dart';
import '../database/db_helper.dart';

class DiscountController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> createDiscount(Discount discount) async {
    final db = await _dbHelper.database;
    await db.insert('discounts', discount.toMap());
  }

  Future<List<Discount>> getAllDiscounts() async {
    final db = await _dbHelper.database;
    final result = await db.query('discounts');
    return result.map((map) => Discount.fromMap(map)).toList();
  }

  Future<void> deleteDiscount(String id) async {
    final db = await _dbHelper.database;
    await db.delete('discounts', where: 'id = ?', whereArgs: [id]);
  }
}
