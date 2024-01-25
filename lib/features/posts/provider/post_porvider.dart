import 'package:charity_management_admin/features/AdminPost/data/post_service.dart';
import 'package:charity_management_admin/features/AdminPost/domain/data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getPostProvider = FutureProvider.autoDispose<List<PostDataModel>>(
    (ref) => PostDataSource().getAllPost());
