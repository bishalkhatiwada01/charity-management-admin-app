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
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.inversePrimary),
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
          title: Text(
            'APPLICATIONS',
            style: TextStyle(
              letterSpacing: 4,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.inversePrimary,
            unselectedLabelColor: Theme.of(context).colorScheme.inversePrimary,
            indicatorColor: Theme.of(context).colorScheme.inversePrimary,
            indicatorWeight: 2.0,
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
