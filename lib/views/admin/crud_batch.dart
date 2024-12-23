// views/admin/crud_batch.dart
import 'package:flutter/material.dart';
import '../../controllers/batch_controller.dart';
import '../../models/batch_model.dart';

class CrudBatchView extends StatefulWidget {
  const CrudBatchView({super.key});

  @override
  _CrudBatchViewState createState() => _CrudBatchViewState();
}

class _CrudBatchViewState extends State<CrudBatchView> {
  final BatchController _batchController = BatchController();
  late Future<List<Batch>> _batches;

  @override
  void initState() {
    super.initState();
    _batches = _batchController.getAllBatches();
  }

  void _refreshBatches() {
    setState(() {
      _batches = _batchController.getAllBatches();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Batches'),
      ),
      body: FutureBuilder<List<Batch>>(
        future: _batches,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No batches found.'));
          } else {
            final batches = snapshot.data!;
            return ListView.builder(
              itemCount: batches.length,
              itemBuilder: (context, index) {
                final batch = batches[index];
                return ListTile(
                  title: Text('Batch ID: ${batch.id}'),
                  subtitle: Text('Quantity: ${batch.quantity}, Status: ${batch.status}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await _batchController.deleteBatch(batch.id);
                      _refreshBatches();
                    },
                  ),
                  onTap: () {
                    // Navigate to batch details or edit view
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new batch
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}