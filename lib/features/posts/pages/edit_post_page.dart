// ignore_for_file: unused_result, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';

import 'package:charity_management_admin/common/widgets/my_button.dart';
import 'package:charity_management_admin/features/posts/data/provider/post_porvider.dart';
import 'package:charity_management_admin/features/posts/domain/data_model.dart';
import 'package:charity_management_admin/features/posts/data/service/post_service.dart';
import 'package:charity_management_admin/features/posts/widgets/my_post_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditPostPage extends ConsumerStatefulWidget {
  final PostDataModel postDataModel;

  const EditPostPage({
    super.key,
    required this.postDataModel,
  });

  @override
  ConsumerState<EditPostPage> createState() => EditPostPageState();
}

class EditPostPageState extends ConsumerState<EditPostPage> {
  late TextEditingController headlineController;
  late TextEditingController contentController;
  late TextEditingController addressController;
  late TextEditingController contactController;
  late TextEditingController imageUrlController;
  late TextEditingController skillsController;
  late TextEditingController interestsController;
  late TextEditingController qualificationsController;
  late TextEditingController targetAmountController;

  late String postImageUrl;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    headlineController =
        TextEditingController(text: widget.postDataModel.postHeadline);
    contentController =
        TextEditingController(text: widget.postDataModel.postContent);
    addressController =
        TextEditingController(text: widget.postDataModel.postAddress);
    contactController =
        TextEditingController(text: widget.postDataModel.postContact);
    postImageUrl = widget.postDataModel.postImageUrl;
    skillsController =
        TextEditingController(text: widget.postDataModel.skills.join(','));
    interestsController =
        TextEditingController(text: widget.postDataModel.interests.join(','));
    qualificationsController = TextEditingController(
        text: widget.postDataModel.qualifications.join(','));
    targetAmountController =
        TextEditingController(text: widget.postDataModel.targetAmount);
  }

  String? _validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          title: Text(
            'EDIT POST',
            style: TextStyle(
              letterSpacing: 4,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
            child: Column(
              children: [
                // Show the actual image from details page

                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 1,
                  controller: headlineController,
                  labelText: 'Headline',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 5,
                  controller: contentController,
                  labelText: 'Content',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 1,
                  controller: addressController,
                  labelText: 'Address',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 1,
                  controller: contactController,
                  labelText: 'Contact No.',
                  obscureText: false,
                ),

                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 2,
                  controller: skillsController,
                  labelText: 'Skills',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 2,
                  controller: interestsController,
                  labelText: 'Interests',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 2,
                  controller: qualificationsController,
                  labelText: 'Qualifications',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 2,
                  controller: targetAmountController,
                  labelText: 'Target Amount',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.h,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  child: Image.network(
                    postImageUrl,
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final postImage =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (postImage != null) {
                      // Delete the old image from Firebase Storage
                      if (postImageUrl != null && postImageUrl.isNotEmpty) {
                        Reference oldImageRef =
                            FirebaseStorage.instance.refFromURL(postImageUrl);
                        await oldImageRef.delete();
                      }

                      // Upload the new image to Firebase Storage
                      final imageId = DateTime.now().toString();
                      final ref = FirebaseStorage.instance
                          .ref()
                          .child('postImages/$imageId');
                      await ref.putFile(File(postImage.path));
                      final url = await ref.getDownloadURL();

                      if (kDebugMode) {
                        print(url);
                      }

                      setState(() {
                        selectedImage = File(postImage.path);
                        postImageUrl = url;
                      });
                    } else {
                      return;
                    }
                  },
                  icon: const Icon(Icons.add_a_photo),
                ),
                SizedBox(height: 10.h),
                MyButton(
                  text: 'Update',
                  onTap: () async {
                    PostDataModel postDataModel = PostDataModel(
                      postId: widget.postDataModel.postId,
                      postHeadline: headlineController.text,
                      postContent: contentController.text,
                      postAddress: addressController.text,
                      postContact: contactController.text,
                      postImageUrl: postImageUrl,
                      postCreatedAt: widget.postDataModel.postCreatedAt,
                      skills: widget.postDataModel.skills,
                      interests: widget.postDataModel.interests,
                      qualifications: widget.postDataModel.qualifications,
                      targetAmount: widget.postDataModel.targetAmount,
                    );
                    await PostDataSource().updatePost(
                      postDataModel: postDataModel,
                    );
                    ref.refresh(postProvider);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Post Updated')),
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
