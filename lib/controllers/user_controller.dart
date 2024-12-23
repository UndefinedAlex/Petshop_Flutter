import '../models/user_model.dart';
import '../database/db_helper.dart';

class UserController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<User?> authenticateUser(String username, String password) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }
}
