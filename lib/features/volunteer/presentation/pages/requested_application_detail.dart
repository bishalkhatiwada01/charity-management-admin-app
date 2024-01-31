import 'package:charity_management_admin/features/volunteer/data/application_service.dart';
import 'package:charity_management_admin/features/volunteer/domain/data_model.dart';
import 'package:charity_management_admin/features/volunteer/presentation/widgets/accept_reject_button.dart';
import 'package:charity_management_admin/features/volunteer/presentation/widgets/my_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestedApplicationDetailPage extends ConsumerStatefulWidget {
  final VolunteerApplication application;

  RequestedApplicationDetailPage({super.key, required this.application});
  @override
  ConsumerState<RequestedApplicationDetailPage> createState() =>
      _RequestedApplicationDetailPageState();
}

ApplicationService _applicationService = ApplicationService();

class _RequestedApplicationDetailPageState
    extends ConsumerState<RequestedApplicationDetailPage> {
  @override
  Widget build(BuildContext context) {
    final applicationData = widget.application;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(
          'APPLICATION DETAILS',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.network(
                  applicationData.post.postImageUrl,
                  height: 200.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Applicants Details: ',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Name',
                      value: applicationData.volunteerName,
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Applied Date',
                      value: applicationData.volunteerCreatedAt,
                    ),
                    SizedBox(height: 8.h),
                    LabelValueWidget(
                      label: 'email',
                      value: applicationData.volunteerEmail,
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Address',
                      value: applicationData.volunteerAddress,
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Contact No. :',
                      value: applicationData.volunteerContactNum,
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Experience',
                      value: applicationData.volunteerExperience,
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Qualification',
                      value: applicationData.volunteerQualification!,
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                        label: 'Skills',
                        value: applicationData.volunteerSkills!.join(', ')),
                    LabelValueWidget(
                        label: 'Interest',
                        value: applicationData.volunteerInterests!.join(', ')),
                    const SizedBox(height: 8.0),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Text(
                          'Post Details: ',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.primary,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                          child: Text(
                            'View Post',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const SizedBox.shrink(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AcceptRejectButtons(
          onAcceptPressed: () async {
            try {
              String response = await _applicationService.acceptApplication(
                  application: applicationData);
              if (response == 'Application Accepted') {
                Navigator.pop(context);
              }
              showSnackBar(context, response);
            } catch (error) {
              print('Error accepting application: $error');
              showSnackBar(context, 'Error accepting application');
            }
          },
          onRejectPressed: () async {
            String result = await _applicationService.rejectApplication(
                applicationId: applicationData.volunteerApplicationId);
            if (result == 'Application Rejected') {
              Navigator.pop(context);
            }
            showSnackBar(context, result);
          },
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
