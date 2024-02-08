import 'package:charity_management_admin/features/posts/data/service/post_service.dart';
import 'package:charity_management_admin/features/posts/domain/data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getPostProvider = FutureProvider.autoDispose<List<PostDataModel>>(
    (ref) => PostDataSource().getAllPost());

final postProvider = FutureProvider<List<PostDataModel>>(
  (ref) => PostDataSource().getAllPost(),
);
