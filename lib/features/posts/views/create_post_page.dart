import 'dart:io';

import 'package:charity_management_admin/common/widgets/my_button.dart';
import 'package:charity_management_admin/features/AdminPost/data/post_service.dart';
import 'package:charity_management_admin/features/posts/data/post_data_service.dart';
import 'package:charity_management_admin/features/posts/widgets/my_post_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _formKey = GlobalKey<FormState>();
  final _postService = PostDataSource();

  final TextEditingController postHeadlineController = TextEditingController();
  final TextEditingController postAddressController = TextEditingController();
  final TextEditingController postContactController = TextEditingController();
  final TextEditingController postContentController = TextEditingController();
  final TextEditingController postImageUrlController = TextEditingController();

  String? _validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  File? selectedImage;

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
    }
  }

  String postImageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
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
                          if (selectedImage != null) {
                            // If an image is selected, upload it to Firebase Storage
                            String filename = DateTime.now()
                                .microsecondsSinceEpoch
                                .toString();

                            // Get the reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDireImages =
                                referenceRoot.child('images');

                            // Creating the reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDireImages.child(filename);

                            // For error handling and success
                            try {
                              await referenceImageToUpload
                                  .putFile(selectedImage!);

                              // Image is uploaded, now adding the image link to the Firestore database
                              postImageUrl =
                                  await referenceImageToUpload.getDownloadURL();
                            } catch (error) {
                              // Handle errors
                              showError(
                                  context, 'Failed to upload image: $error');
                              return;
                            }
                          }
                          // add the package image picker
                          final file = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (file == null) return;
                          String filename =
                              DateTime.now().microsecondsSinceEpoch.toString();

                          // Get the reference to storage root
                          // creating the image folder and uploading image inside it
                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDireImages =
                              referenceRoot.child('images');

                          //creating the reference for the image to be stored
                          Reference referenceImageToUpload =
                              referenceDireImages.child(filename);

                          // for error handleing and success
                          try {
                            setState(() {
                              selectedImage = File(file.path);
                            });

                            await referenceImageToUpload
                                .putFile(File(file.path));

                            // image is uploaded, now adding the image link to firebase database
                            postImageUrl =
                                await referenceImageToUpload.getDownloadURL();
                          } catch (error) {
                            // errors
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
