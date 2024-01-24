import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void submitButtonLogic({
  required BuildContext context,
  required String headline,
  required String content,
  required String address,
  required String contact,
  required String postId,
  required Function(Map<String, dynamic>)? onUpdate,
  required TextEditingController headlineController,
  required TextEditingController contentController,
  required TextEditingController addressController,
  required TextEditingController contactController,
}) async {
  // Validate input fields here if needed
  bool headlineError = headlineController.text.trim().isEmpty;
  bool contentError = contentController.text.trim().isEmpty;
  bool addressError = addressController.text.trim().isEmpty;
  bool contactNoError = contactController.text.trim().isEmpty;

  if (headlineError || contentError || addressError || contactNoError) {
    // Show error and return if any field is empty
    showError(context, 'Please fill in all fields');
    return;
  }

  // Get the updated values from text controllers
  String updatedHeadline = headlineController.text.trim();
  String updatedContent = contentController.text.trim();
  String updatedAddress = addressController.text.trim();
  String updatedContact = contactController.text.trim();

  // Perform the update operation
  await FirebaseFirestore.instance.collection('posts').doc(postId).update({
    'headline': updatedHeadline,
    'content': updatedContent,
    'address': updatedAddress,
    'contact': updatedContact,
    // Add other fields as needed
  });

  // Get the updated data
  Map<String, dynamic> updatedData = {
    'headline': updatedHeadline,
    'content': updatedContent,
    'address': updatedAddress,
    'contact': updatedContact,
    // Add other fields as needed
  };

  // Check if onUpdate is not null before calling it
  if (onUpdate != null) {
    onUpdate(updatedData);
  }

  // Navigate back to PostDetailsPage with the updated data
  Navigator.pop(context, updatedData);

  // Clear text controllers
  headlineController.clear();
  contentController.clear();
  addressController.clear();
  contactController.clear();
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
