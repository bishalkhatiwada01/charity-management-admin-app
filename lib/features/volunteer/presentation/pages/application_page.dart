import 'package:charity_management_admin/features/volunteer/presentation/pages/tabs/accepted_application_tab.dart';
import 'package:charity_management_admin/features/volunteer/presentation/pages/tabs/requested_application_tab.dart';
import 'package:flutter/material.dart';


class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'APPLICATIONS',
            style: TextStyle(
              letterSpacing: 4,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Requests'),
              Tab(text: 'Accepted'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RequestedApplicationsTab(),
            AcceptedApplicationsTab(),
          ],
        ),
      ),
    );
  }
}
