// views/admin/crud_cashier.dart
import 'package:flutter/material.dart';
import '../../controllers/cashier_controller.dart';
import '../../models/user_model.dart';

class CrudCashierView extends StatefulWidget {
  const CrudCashierView({super.key});

  @override
  _CrudCashierViewState createState() => _CrudCashierViewState();
}

class _CrudCashierViewState extends State<CrudCashierView> {
  final CashierController _cashierController = CashierController();
  late Future<List<User>> _cashiers;

  @override
  void initState() {
    super.initState();
    _cashiers = _cashierController.getAllCashiers();
  }

  void _refreshCashiers() {
    setState(() {
      _cashiers = _cashierController.getAllCashiers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Cashiers'),
      ),
      body: FutureBuilder<List<User>>(
        future: _cashiers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cashiers found.'));
          } else {
            final cashiers = snapshot.data!;
            return ListView.builder(
              itemCount: cashiers.length,
              itemBuilder: (context, index) {
                final cashier = cashiers[index];
                return ListTile(
                  title: Text('Cashier: ${cashier.username}'),
                  subtitle: Text('Role: ${cashier.role}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await _cashierController.deleteCashier(cashier.id);
                      _refreshCashiers();
                    },
                  ),
                  onTap: () {
                    // Navigate to cashier details or edit view
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new cashier
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}