import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Auth
import '../views/auth/login.dart';

// Admin
import '../views/admin/dashboard.dart';
import '../views/admin/activity_log.dart';
import '../views/admin/crud_batch.dart';
import '../views/admin/crud_cashier.dart';
import '../views/admin/crud_discount.dart';
import '../views/admin/crud_product.dart';
import '../views/admin/transaction_view.dart';

// Cashier
import '../views/cashier/dashboard.dart';

class AppRoutes {
  // Define named route constants
  static const String home = '/';
  static const String login = '/login';

  // Admin Routes
  static const String adminDashboard = '/admin/dashboard';
  static const String activityLog = '/admin/activity_log';
  static const String crudBatch = '/admin/crud_batch';
  static const String crudCashier = '/admin/crud_cashier';
  static const String crudDiscount = '/admin/crud_discount';
  static const String crudProduct = '/admin/crud_product';
  static const String transactionView = '/admin/transaction_view';

  // Cashier Routes
  static const String cashierDashboard = '/cashier/dashboard';

  // Map of all the routes
  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeRedirectView(),
    login: (context) => const LoginView(),

    // Admin
    adminDashboard: (context) => AdminDashboardView(),
    activityLog: (context) => const ActivityLogView(),
    crudBatch: (context) => const CrudBatchView(),
    crudCashier: (context) => const CrudCashierView(),
    crudDiscount: (context) => CrudDiscountView(),
    crudProduct: (context) => CrudProductView(),
    transactionView: (context) => TransactionView(),

    // Cashier
    cashierDashboard: (context) => CashierDashboardView(),
  };
}

// HomeRedirectView determines where the user should go based on session
class HomeRedirectView extends StatelessWidget {
  const HomeRedirectView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final prefs = snapshot.data as SharedPreferences;

          // Check the role saved in SharedPreferences
          final role = prefs.getString('loggedInUserRole');
          if (role == 'admin') {
            return AdminDashboardView();
          } else if (role == 'cashier') {
            return CashierDashboardView();
          } else {
            // If no session is found, redirect to Login
            return const LoginView();
          }
        }

        // Show a loading indicator while the session is being checked
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
