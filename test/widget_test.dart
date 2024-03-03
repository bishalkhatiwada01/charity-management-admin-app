import 'package:charity_management_admin/features/posts/data/service/edit_delete_logic.dart';
import 'package:charity_management_admin/features/posts/data/service/post_service.dart';
import 'package:charity_management_admin/features/volunteer/data/application_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockFirebaseApp extends Mock implements FirebaseApp {}

class MockFirebase extends Mock implements Firebase {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  // to test create post service
  group('PostDataSource', () {
    late PostDataSource postDataSource;
    late MockFirebaseFirestore mockFirebaseFirestore;
    late MockCollectionReference mockCollectionReference;
    late MockDocumentReference mockDocumentReference;

    setUp(() async {
      MockFirebaseApp mockFirebaseApp = MockFirebaseApp();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockCollectionReference = MockCollectionReference();
      mockDocumentReference = MockDocumentReference();
      postDataSource = PostDataSource();

      when(mockFirebaseFirestore.collection(any ?? '')).thenReturn(
          mockCollectionReference as CollectionReference<Map<String, dynamic>>);
      when(mockCollectionReference.add(any))
          .thenAnswer((_) async => mockDocumentReference);
    });

    test('createPost', () async {
      final result = await postDataSource.createPost(
        postHeadline: 'headline',
        postAddress: 'address',
        postContact: 'contact',
        postContent: 'content',
        postImageUrl: 'imageUrl',
        skills: ['skill1', 'skill2'],
        interests: ['interest1', 'interest2'],
        qualifications: ['qualification1', 'qualification2'],
        targetAmount: 'targetAmount',
      );

      verify(mockCollectionReference.add(any)).called(1);
      expect(result, 'Post Created');
    });
  });

  // edit post
  group('EditLogic', () {
    late MockFirebaseFirestore mockFirebaseFirestore;
    late MockCollectionReference mockCollectionReference;
    late MockDocumentReference mockDocumentReference;

    setUp(() {
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockCollectionReference = MockCollectionReference();
      mockDocumentReference = MockDocumentReference();

      when(mockFirebaseFirestore.collection(any ?? '')).thenReturn(
          mockCollectionReference as CollectionReference<Map<String, dynamic>>);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.delete()).thenAnswer((_) async => null);
    });
  });

  group('ApplicationService', () {
    late ApplicationService applicationService;
    late MockFirebaseFirestore mockFirebaseFirestore;
    late MockDocumentReference mockDocumentReference;

    setUp(() {
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockDocumentReference = MockDocumentReference();
      applicationService = ApplicationService();

      when(mockFirebaseFirestore.collection(any ?? '')).thenReturn(
          mockFirebaseFirestore as CollectionReference<Map<String, dynamic>>);
      when(mockDocumentReference.id).thenReturn('test_id');
      when(mockFirebaseFirestore.doc(any ?? '')).thenReturn(
          mockDocumentReference as DocumentReference<Map<String, dynamic>>);
      when(mockDocumentReference.delete()).thenAnswer((_) async => null);
    });

    test('acceptApplication', () async {
      verify(mockFirebaseFirestore.doc('test_id')).called(1);
      verify(mockDocumentReference.delete()).called(1);
    });
    test('rejectApplication', () async {
      final result =
          await applicationService.rejectApplication(applicationId: 'test_id');

      verify(mockFirebaseFirestore.doc('test_id')).called(1);
      verify(mockDocumentReference.delete()).called(1);
      expect(result, 'Application Deleted');
    });
  });
}
