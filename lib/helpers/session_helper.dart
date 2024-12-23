import 'package:shared_preferences/shared_preferences.dart';

class SessionHelper {
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<String?> getLoggedInUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('loggedInUserId');
  }

  Future<String?> getLoggedInUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('loggedInUserRole');
  }
}
