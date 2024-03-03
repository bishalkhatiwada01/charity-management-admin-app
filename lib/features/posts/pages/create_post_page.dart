import 'dart:io';
import 'package:charity_management_admin/common/widgets/my_button.dart';
import 'package:charity_management_admin/features/posts/data/provider/post_porvider.dart';
import 'package:charity_management_admin/features/posts/data/service/post_service.dart';
import 'package:charity_management_admin/features/posts/widgets/my_post_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final _postService = PostDataSource();

  late String postImageUrl;
  File? selectedImage;

  final TextEditingController postHeadlineController = TextEditingController();
  final TextEditingController postAddressController = TextEditingController();
  final TextEditingController postContactController = TextEditingController();
  final TextEditingController postContentController = TextEditingController();
  final TextEditingController postImageUrlController = TextEditingController();
  final TextEditingController volunteerSkillsController =
      TextEditingController();
  final TextEditingController volunteerQualifiController =
      TextEditingController();
  final TextEditingController volunteerIntersController =
      TextEditingController();
  final TextEditingController targetAmountController = TextEditingController();

  String? _validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    // Send the notification...
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle notification when app is in foreground
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification when app is opened from a terminated state
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String result = await _postService.createPost(
        postHeadline: postHeadlineController.text.trim(),
        postAddress: postAddressController.text.trim(),
        postContact: postContactController.text.trim(),
        postContent: postContentController.text.trim(),
        postImageUrl: postImageUrl,
        skills: volunteerSkillsController.text.trim().split(','),
        interests: volunteerIntersController.text.trim().split(','),
        qualifications: volunteerQualifiController.text.trim().split(','),
        targetAmount: targetAmountController.text.trim(),
      );
      ref.refresh(postProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post Created')),
      );
      Navigator.pop(context);

      void addNotificationToFirestore() async {
        CollectionReference notifications =
            FirebaseFirestore.instance.collection('post_created_notifications');

        await notifications.add({
          'postHeadline': postHeadlineController,
          'time': DateTime.now().toIso8601String(),
          'address': postAddressController,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        title: const Text(
          'CREATE POST',
          style: TextStyle(
            letterSpacing: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 1,
                  controller: postHeadlineController,
                  labelText: 'Headline',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 5,
                  controller: postContentController,
                  labelText: 'Content',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 1,
                  controller: postAddressController,
                  labelText: 'Address',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 1,
                  controller: postContactController,
                  labelText: 'Contact No.',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                Divider(color: Theme.of(context).colorScheme.inversePrimary),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'For Volunteers',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 1,
                  controller: volunteerSkillsController,
                  labelText: 'Skills',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 1,
                  controller: volunteerQualifiController,
                  labelText: 'Qualifications',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 1,
                  controller: volunteerIntersController,
                  labelText: 'Interests',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  validator: _validateTextField,
                  maxlines: 1,
                  controller: targetAmountController,
                  labelText: 'Target Amount',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                selectedImage != null
                    ? Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Image.file(
                                selectedImage!,
                                height: 150.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectedImage = null;
                              });
                            },
                            icon: Icon(
                              Icons.delete_forever_sharp,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      )
                    : IconButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final postImage = await picker.pickImage(
                              source: ImageSource.camera);

                          if (postImage != null) {
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
                  text: 'Post',
                  onTap: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
