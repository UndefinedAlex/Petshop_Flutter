import '../models/activity_log.dart';
import '../database/db_helper.dart';

class ActivityLogController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Log an activity
  Future<void> logActivity(ActivityLog log) async {
    final db = await _dbHelper.database;
    await db.insert('activity_log', log.toMap());
  }

  // Get all logs
  Future<List<ActivityLog>> getAllLogs() async {
    final db = await _dbHelper.database;
    final result = await db.query('activity_log');
    return result.map((map) => ActivityLog.fromMap(map)).toList();
  }

  // Get logs filtered by actionType
  Future<List<ActivityLog>> getLogsByActionType(String actionType) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'activity_log',
      where: 'action_type = ?',
      whereArgs: [actionType],
    );
    return result.map((map) => ActivityLog.fromMap(map)).toList();
  }

  // Get logs for a specific user
  Future<List<ActivityLog>> getLogsByUser(String userId) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'activity_log',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return result.map((map) => ActivityLog.fromMap(map)).toList();
  }

  // Delete a log by ID
  Future<void> deleteLog(String id) async {
    final db = await _dbHelper.database;
    await db.delete('activity_log', where: 'id = ?', whereArgs: [id]);
  }

  // Delete all logs (use cautiously)
  Future<void> clearLogs() async {
    final db = await _dbHelper.database;
    await db.delete('activity_log');
  }
}
