// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:charity_management_admin/common/widgets/my_button.dart';
import 'package:charity_management_admin/features/dashbord/views/home_page.dart';
import 'package:charity_management_admin/features/posts/services/post_service.dart';
import 'package:charity_management_admin/features/posts/widgets/my_post_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
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
  final TextEditingController volunteerQualificationsController =
      TextEditingController();
  final TextEditingController volunteerInterestsController =
      TextEditingController();

  String? _validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
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
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  List<String> volunteerSkills = [];
  List<String> volunteerQualifications = [];
  List<String> volunteerInterests = [];
  List<String> allSkills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
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
                  maxlines: 1,
                  controller: postHeadlineController,
                  labelText: 'Headline',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  maxlines: 5,
                  controller: postContentController,
                  labelText: 'Content',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  maxlines: 1,
                  controller: postAddressController,
                  labelText: 'Address',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  maxlines: 1,
                  controller: postContactController,
                  labelText: 'Contact No.',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  maxlines: 1,
                  controller: volunteerSkillsController,
                  labelText: 'Skills',
                  obscureText: false,
                ),
                // ChipsInput<String>(
                //   decoration: InputDecoration(labelText: "Volunteer Skills"),
                //   onChanged: (value) {
                //     volunteerSkills = List<String>.from(value);
                //   },
                //   findSuggestions: (String query) {
                //     if (query.isNotEmpty) {
                //       var lowercaseQuery = query.toLowerCase();
                //       return allSkills.where((skill) {
                //         return skill
                //             .toLowerCase()
                //             .contains(query.toLowerCase());
                //       }).toList(growable: false)
                //         ..sort((a, b) => a
                //             .toLowerCase()
                //             .indexOf(lowercaseQuery)
                //             .compareTo(
                //                 b.toLowerCase().indexOf(lowercaseQuery)));
                //     } else {
                //       return const <String>[];
                //     }
                //   },
                //   chipBuilder: (context, state, String value) {
                //     return InputChip(
                //       key: ObjectKey(value),
                //       label: Text(value),
                //       onDeleted: () => state.deleteChip(value),
                //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //     );
                //   },
                //   suggestionBuilder: (context, state, String value) {
                //     return ListTile(
                //       key: ObjectKey(value),
                //       title: Text(value),
                //       onTap: () => state.selectSuggestion(value),
                //     );
                //   },
                // ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  maxlines: 1,
                  controller: volunteerQualificationsController,
                  labelText: 'Qualifications',
                  obscureText: false,
                ),
                SizedBox(height: 10.h),
                MyPostTextField(
                  maxlines: 1,
                  controller: volunteerInterestsController,
                  labelText: 'Interests',
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
                              source: ImageSource.gallery);

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
                  text: 'Submit',
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
