// TransactionView
import 'package:flutter/material.dart';
import '../../controllers/transaction_controller.dart';
import '../../controllers/transaction_item_controller.dart';
import '../../models/transaction_model.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  _TransactionViewState createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  final TransactionController _transactionController = TransactionController();
  final TransactionItemController _transactionItemController = TransactionItemController();
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final transactions = await _transactionController.getAllTransactions();
    setState(() {
      _transactions = transactions;
    });
  }

  Future<void> _viewTransactionItems(String transactionId) async {
    final items = await _transactionItemController.getAllTransactionItems();
    final transactionItems = items.where((item) => item.transactionId == transactionId).toList();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Transaction Items'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: transactionItems.map((item) => Text('${item.productId} x ${item.quantity}')).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Transactions'),
      ),
      body: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          final transaction = _transactions[index];
          return ListTile(
            title: Text('Transaction ${transaction.id}'),
            subtitle: Text('Total: ${transaction.totalAmount}'),
            trailing: IconButton(
              icon: Icon(Icons.info),
              onPressed: () => _viewTransactionItems(transaction.id),
            ),
          );
        },
      ),
    );
  }
}
