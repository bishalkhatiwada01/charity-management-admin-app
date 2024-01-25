import 'package:charity_management_admin/features/volunteer/presentation/pages/tabs/accepted_application_tab.dart';
import 'package:charity_management_admin/features/volunteer/presentation/pages/tabs/requested_application_tab.dart';
import 'package:flutter/material.dart';

class AllApplicationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Applications'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Requests'),
              Tab(text: 'Accepted'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllApplicationsTab(),
            AcceptedApplicationsTab(),
          ],
        ),
      ),
    );
  }
}
