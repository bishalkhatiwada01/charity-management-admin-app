import 'package:charity_management_admin/features/volunteer/data/accepted_application_service.dart';
import 'package:charity_management_admin/features/volunteer/data/data_service.dart';
import 'package:charity_management_admin/features/volunteer/domain/data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final volunteerApplicationProvider = FutureProvider<List<VolunteerApplication>>(
  (ref) => DataService().getApplication(),
);

final acceptedApplicationProvider = FutureProvider<List<VolunteerApplication>>(
  (ref) => AcceptedApplicationService().getAcceptedApplication(),
);
