import 'package:charity_management_admin/common/functions/date_formatted.dart';
import 'package:charity_management_admin/features/volunteer/domain/application_data_provider.dart';
import 'package:charity_management_admin/features/volunteer/presentation/pages/accepted_application_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcceptedApplicationsTab extends ConsumerWidget {
  const AcceptedApplicationsTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final applicationList = ref.watch(acceptedApplicationProvider);

    return Center(
      child: applicationList.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final application = data[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            right:
                                BorderSide(width: 1.0, color: Colors.white24),
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                              NetworkImage(application.post.postImageUrl),
                        ),
                      ),
                      title: Text(
                        application.volunteerName,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            application.post.postHeadline,
                            style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            formatDateTime(application.volunteerCreatedAt),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AcceptedApplicationDetailPage(
                                application: application),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
        error: (error, stack) => Center(
          child: Center(child: Text("No data")),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
