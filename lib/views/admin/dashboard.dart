// admin/dashboard.dart
import 'package:flutter/material.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardCard(
                    title: 'Total Sales',
                    value: 'Rp 1,500,000',
                    icon: Icons.attach_money,
                  ),
                  DashboardCard(
                    title: 'Total Products',
                    value: '120',
                    icon: Icons.inventory,
                  ),
                  DashboardCard(
                    title: 'Total Staff',
                    value: '5',
                    icon: Icons.people,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Recent Activities',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              RecentActivitiesList(),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to staff management
                },
                icon: Icon(Icons.manage_accounts),
                label: Text('Manage Staff'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to inventory management
                },
                icon: Icon(Icons.inventory_2),
                label: Text('Manage Inventory'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardCard({super.key, 
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        width: 100,
        height: 100,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            SizedBox(height: 10),
            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(title, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class RecentActivitiesList extends StatelessWidget {
  const RecentActivitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.event_note),
          title: Text('Activity $index'),
          subtitle: Text('Description of activity $index'),
        );
      },
    );
  }
}
