// CrudProductView
import 'package:flutter/material.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';

class CrudProductView extends StatefulWidget {
  const CrudProductView({super.key});

  @override
  _CrudProductViewState createState() => _CrudProductViewState();
}

class _CrudProductViewState extends State<CrudProductView> {
  final ProductController _productController = ProductController();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await _productController.getAllProducts();
    setState(() {
      _products = products;
    });
  }

  Future<void> _addProduct() async {
    final product = Product(
      id: DateTime.now().toString(),
      batchId: 'batch1',
      userId: 'user1',
      name: 'New Product',
      category: 'Category1',
      barcode: '123456789',
      unit: 'pcs',
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _productController.createProduct(product);
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('Category: ${product.category}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await _productController.deleteProduct(product.id);
                _loadProducts();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: Icon(Icons.add),
      ),
    );
  }
}
