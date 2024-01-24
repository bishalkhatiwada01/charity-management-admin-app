import 'dart:io';

import 'package:charity_management_admin/common/widgets/my_button.dart';
import 'package:charity_management_admin/features/posts/widgets/my_post_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';


class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  // for validate
  bool headlineError = false;
  bool contentError = false;
  bool addressError = false;
  bool contactNoError = false;
  // Text controllers
  final headlineController = TextEditingController();
  final contentController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();

  // Image file
  File? selectedImage;

  void createPost() async {
    String headline = headlineController.text.trim();
    String content = contentController.text.trim();
    String address = addressController.text.trim();
    String contact = contactController.text.trim();

    if (headline.isEmpty ||
        content.isEmpty ||
        address.isEmpty ||
        contact.isEmpty) {
      // Show error
      showError(context, 'Please fill in all the fields');
      return;
    }

    if (selectedImage != null) {
      // If an image is selected, upload it to Firebase Storage
      String filename = DateTime.now().microsecondsSinceEpoch.toString();

      // Get the reference to storage root
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDireImages = referenceRoot.child('images');

      // Creating the reference for the image to be stored
      Reference referenceImageToUpload = referenceDireImages.child(filename);

      // For error handling and success
      try {
        await referenceImageToUpload.putFile(selectedImage!);

        // Image is uploaded, now adding the image link to the Firestore database
        imageUrl = await referenceImageToUpload.getDownloadURL();
      } catch (error) {
        // Handle errors
        showError(context, 'Failed to upload image: $error');
        return;
      }
    }

    // Add to Firestore
    FirebaseFirestore.instance.collection('posts').add({
      'headline': headline,
      'content': content,
      'address': address,
      'contact': contact,
      'createdAt': Timestamp.now(),
      'imageUrl': imageUrl,
    }).then((docRef) {
      if (kDebugMode) {
        print('Added post with ID: ${docRef.id}');
      }
      // Data added, clear fields
      headlineController.clear();
      contentController.clear();
      addressController.clear();
      contactController.clear();
      selectedImage = null;
    });
    Navigator.of(context).pop();
  }

  String imageUrl = '';

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
            'C R E A T E   P O S T',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  MyPostTextField(
                    maxlines: 1,
                    controller: headlineController,
                    labelText: 'Headline',
                    obscureText: false,
                  ),
                  SizedBox(height: 10.h),
                  MyPostTextField(
                    maxlines: 5,
                    controller: contentController,
                    labelText: 'Content',
                    obscureText: false,
                  ),
                  SizedBox(height: 10.h),
                  MyPostTextField(
                    maxlines: 1,
                    controller: addressController,
                    labelText: 'Address',
                    obscureText: false,
                  ),
                  SizedBox(height: 10.h),
                  MyPostTextField(
                    maxlines: 1,
                    controller: contactController,
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ],
                        )
                      : IconButton(
                          onPressed: () async {
                            // add the package image picker
                            final file = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (file == null) return;
                            String filename = DateTime.now()
                                .microsecondsSinceEpoch
                                .toString();

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
                              imageUrl =
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
                    onTap: createPost,
                  ),
                ],
              ),
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
