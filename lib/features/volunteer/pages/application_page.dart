import 'package:charity_management_admin/features/volunteer/pages/application_detail.dart';
import 'package:charity_management_admin/features/volunteer/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ApplicationsPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends ConsumerState<ApplicationsPage> {
  @override
  Widget build(BuildContext context) {
    final applicationList = ref.watch(volunteerApplicationProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Applications'),
      ),
      body: applicationList.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final application = data[index];
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ApplicationDetailPage(
                              application: application,
                            )));
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(application.post.imageUrl),
                  ),
                  title: Text(application.volunteer.volunteerName),
                  subtitle: Text(
                    DateFormat.yMMMd().format(
                      DateTime.parse(application.createdAt),
                    ),
                  ),
                  trailing: Text(application.post.headline),
                ),
              );
            },
          );
        },
        error: (error, stack) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
