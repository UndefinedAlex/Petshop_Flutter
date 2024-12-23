import '../models/product_model.dart';
import '../database/db_helper.dart';

class ProductController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> createProduct(Product product) async {
    final db = await _dbHelper.database;
    await db.insert('products', product.toMap());
  }

  Future<Product?> getProductById(String id) async {
    final db = await _dbHelper.database;
    final result = await db.query('products', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Product.fromMap(result.first) : null;
  }

  Future<List<Product>> getAllProducts() async {
    final db = await _dbHelper.database;
    final result = await db.query('products');
    return result.map((map) => Product.fromMap(map)).toList();
  }

  Future<void> updateProduct(Product product) async {
    final db = await _dbHelper.database;
    await db.update('products', product.toMap(), where: 'id = ?', whereArgs: [product.id]);
  }

  Future<void> deleteProduct(String id) async {
    final db = await _dbHelper.database;
    await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}
