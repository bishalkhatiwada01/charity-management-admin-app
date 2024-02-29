import 'package:charity_management_admin/features/profile/data/get_admin_user.dart';
import 'package:charity_management_admin/features/profile/domain/admin_user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminUserProvider = FutureProvider<AdminUser>((ref) async {
  return UserService().getCurrentUser();
});
