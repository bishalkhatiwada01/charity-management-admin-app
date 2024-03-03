// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:charity_management_admin/api/api_keys.dart';
import 'package:charity_management_admin/api/end_points.dart';
import 'package:charity_management_admin/api/firebase_api.dart';
import 'package:charity_management_admin/features/volunteer/data/application_service.dart';
import 'package:charity_management_admin/features/volunteer/providers/application_data_provider.dart';
import 'package:charity_management_admin/features/volunteer/domain/volunteer_application_model.dart';
import 'package:charity_management_admin/features/volunteer/presentation/pages/application_page.dart';
import 'package:charity_management_admin/features/volunteer/presentation/widgets/accept_reject_button.dart';
import 'package:charity_management_admin/features/volunteer/presentation/widgets/my_rich_text.dart';
import 'package:charity_management_admin/firebase_options.dart';
import 'package:charity_management_admin/main.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestedApplicationDetailPage extends ConsumerStatefulWidget {
  final VolunteerApplication application;

  const RequestedApplicationDetailPage({super.key, required this.application});

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
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(
          'APPLICATION DETAILS',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
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
                      label: 'Email',
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
                      label: 'Interest',
                      value: applicationData.volunteerInterests!.join(', '),
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Skills',
                      value: applicationData.volunteerSkills!.join(', '),
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Qualification',
                      value: applicationData.volunteerQualification!.join(', '),
                    ),
                    const Divider(),
                    Text(
                      'Post Details: ',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    LabelValueWidget(
                      label: 'Headline',
                      value: applicationData.post.postHeadline,
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Description',
                      value: applicationData.post.postContent,
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Location',
                      value: applicationData.post.postAddress,
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Posted Date',
                      value: applicationData.post.postDate,
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(),
                    Text(
                      'Needed:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    LabelValueWidget(
                      label: 'Interest',
                      value: applicationData.post.interests.join(', '),
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Skills',
                      value: applicationData.post.skills.join(', '),
                    ),
                    const SizedBox(height: 8.0),
                    LabelValueWidget(
                      label: 'Qualification',
                      value: applicationData.post.qualifications.join(', '),
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
                await sendNotification(
                  token: applicationData.volunteerToken,
                  title: "Application Accepted",
                  message:
                      "Dear applicant, your application has been accepted in ${applicationData.post.postHeadline}",
                );
                final response = await _applicationService.sendNotification(
                    applicationData: applicationData);
                print(response);
                ref.refresh(volunteerApplicationProvider);
                ref.refresh(acceptedApplicationProvider);
                // Pop the current page
                Navigator.pop(context);
              }
              showSnackBar(context, response);
            } catch (error) {
              if (kDebugMode) {
                print('Error accepting application: $error');
              }
              showSnackBar(context, 'Error accepting application');
            }
          },
          onRejectPressed: () async {
            String result = await _applicationService.rejectApplication(
                applicationId: applicationData.volunteerApplicationId);
            if (result == 'Application Rejected') {
              ref.refresh(volunteerApplicationProvider);

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

Future<void> sendNotification(
    {required String token,
    required String title,
    required String message,
    Map<String, dynamic>? notificationData}) async {
  final dio = Dio(BaseOptions(
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    },
    baseUrl: ApiEndPoints.baseNotificationUrl,
  ));
  try {
    await dio.post(ApiEndPoints.baseNotificationUrl, data: {
      "to": token,
      "priority": "High",
      "default_notification_channel_id": "high_importance_channel",
      "notification": {
        "body": message,
        "title": title,
      },
      "data": notificationData,
    });
  } on FirebaseException catch (err) {
    throw Exception(err.message);
  }
}
