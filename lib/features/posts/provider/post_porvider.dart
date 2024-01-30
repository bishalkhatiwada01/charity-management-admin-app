import 'package:charity_management_admin/features/posts/services/post_service.dart';
import 'package:charity_management_admin/features/posts/data/post_data/data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getPostProvider = FutureProvider.autoDispose<List<PostDataModel>>(
    (ref) => PostDataSource().getAllPost());
