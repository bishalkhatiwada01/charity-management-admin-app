import 'package:charity_management_admin/features/volunteer/data/application_service.dart';
import 'package:charity_management_admin/features/volunteer/domain/volunteer_application_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final volunteerApplicationProvider = FutureProvider<List<VolunteerApplication>>(
  (ref) => ApplicationService().getApplication(),
);

final acceptedApplicationProvider = FutureProvider<List<VolunteerApplication>>(
  (ref) => ApplicationService().getAcceptedApplication(),
);
