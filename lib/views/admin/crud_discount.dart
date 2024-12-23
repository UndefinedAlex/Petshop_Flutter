// CrudDiscountView
import 'package:flutter/material.dart';
import '../../controllers/discount_controller.dart';
import '../../models/discount_model.dart';

class CrudDiscountView extends StatefulWidget {
  const CrudDiscountView({super.key});

  @override
  _CrudDiscountViewState createState() => _CrudDiscountViewState();
}

class _CrudDiscountViewState extends State<CrudDiscountView> {
  final DiscountController _discountController = DiscountController();
  List<Discount> _discounts = [];

  @override
  void initState() {
    super.initState();
    _loadDiscounts();
  }

  Future<void> _loadDiscounts() async {
    final discounts = await _discountController.getAllDiscounts();
    setState(() {
      _discounts = discounts;
    });
  }

  Future<void> _addDiscount() async {
    final discount = Discount(
      id: DateTime.now().toString(),
      discountType: 'Percentage',
      discountValue: 10.0,
      startDate: DateTime.now().millisecondsSinceEpoch,
      endDate: DateTime.now().add(Duration(days: 7)).millisecondsSinceEpoch,
      productId: null,
      transactionId: null,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _discountController.createDiscount(discount);
    _loadDiscounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Discounts'),
      ),
      body: ListView.builder(
        itemCount: _discounts.length,
        itemBuilder: (context, index) {
          final discount = _discounts[index];
          return ListTile(
            title: Text(discount.discountType),
            subtitle: Text('Value: ${discount.discountValue}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await _discountController.deleteDiscount(discount.id);
                _loadDiscounts();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDiscount,
        child: Icon(Icons.add),
      ),
    );
  }
}