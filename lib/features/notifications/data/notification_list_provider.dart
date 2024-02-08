import 'package:charity_management_admin/features/notifications/data/notification_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationListProvider =
    StreamProvider((ref) => NotificationDataSource().getNotifications());
final notificationDataSourceProvider =
    Provider((ref) => NotificationDataSource());
