import 'package:flutter/material.dart';
import '../../controllers/activity_log_controller.dart';
import '../../models/activity_log.dart';

class ActivityLogView extends StatefulWidget {
  const ActivityLogView({super.key});

  @override
  State<ActivityLogView> createState() => _ActivityLogViewState();
}

class _ActivityLogViewState extends State<ActivityLogView> {
  final ActivityLogController _controller = ActivityLogController();
  List<ActivityLog> _logs = [];
  String? _filterType; // Filter by actionType
  String? _filterUserId; // Filter by userId

  @override
  void initState() {
    super.initState();
    _fetchLogs();
  }

  // Fetch logs from the database
  Future<void> _fetchLogs() async {
    List<ActivityLog> logs;
    if (_filterType != null) {
      logs = await _controller.getLogsByActionType(_filterType!);
    } else if (_filterUserId != null) {
      logs = await _controller.getLogsByUser(_filterUserId!);
    } else {
      logs = await _controller.getAllLogs();
    }
    setState(() {
      _logs = logs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: _logs.isEmpty
          ? const Center(child: Text('No logs found.'))
          : ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                final log = _logs[index];
                return ListTile(
                  title: Text('${log.actionType} - ${log.entityType}'),
                  subtitle: Text(
                      'User: ${log.userId}\n${log.description}\n${DateTime.fromMillisecondsSinceEpoch(log.didAt)}'),
                  isThreeLine: true,
                );
              },
            ),
    );
  }

  // Filter dialog for actionType or userId
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String filterType = '';
        String filterUserId = '';
        return AlertDialog(
          title: const Text('Filter Logs'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Action Type'),
                onChanged: (value) {
                  filterType = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'User ID'),
                onChanged: (value) {
                  filterUserId = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _filterType = filterType.isNotEmpty ? filterType : null;
                  _filterUserId = filterUserId.isNotEmpty ? filterUserId : null;
                });
                _fetchLogs();
                Navigator.of(context).pop();
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}
