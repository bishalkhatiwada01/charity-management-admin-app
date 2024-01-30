// import 'dart:io';

// import 'package:charity_management_admin/common/widgets/my_button.dart';
// import 'package:charity_management_admin/features/posts/data/post_data/data_model.dart';
// import 'package:charity_management_admin/features/posts/services/submit_button_logic.dart.dart';
// import 'package:charity_management_admin/features/posts/widgets/my_post_textfield.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';

// class EditPostPage extends StatefulWidget {

//   final String initialHeadline;
//   final String initialContent;
//   final String initialAddress;
//   final String initialContact;
//   // final String initialImageUrl;
//   final String postId;
//   final Function(Map<String, dynamic>)? onUpdate; // Make onUpdate optional

//   const EditPostPage({
//     super.key,
//     required this.initialHeadline,
//     required this.initialContent,
//     required this.initialAddress,
//     required this.initialContact,
//     // required this.initialImageUrl,
//     required this.postId,
//     this.onUpdate, // Pass the onUpdate as an optional parameter
//   });

//   @override
//   State<EditPostPage> createState() => EditPostPageState();
// }

// class EditPostPageState extends State<EditPostPage> {
//   // for validation
//   bool headlineError = false;
//   bool contentError = false;
//   bool addressError = false;
//   bool contactNoError = false;

//   // Text controllers
//   final headlineController = TextEditingController();
//   final contentController = TextEditingController();
//   final addressController = TextEditingController();
//   final contactController = TextEditingController();

//   String imageUrl = '';

//   @override
//   void initState() {
//     super.initState();
//     // Set initial values to text controllers
//     headlineController.text = widget.initialHeadline;
//     contentController.text = widget.initialContent;
//     addressController.text = widget.initialAddress;
//     contactController.text = widget.initialContact;
//     // imageUrl = widget.initialImageUrl;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           iconTheme: IconThemeData(
//             color: Theme.of(context).colorScheme.inversePrimary,
//           ),
//           title: Text(
//             'EDIT POST',
//             style: TextStyle(
//               letterSpacing: 4,
//               color: Theme.of(context).colorScheme.inversePrimary,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
//             child: Column(
//               children: [
//                 // Show the actual image from details page

//                 SizedBox(height: 10.h),
//                 MyPostTextField(
//                   maxlines: 1,
//                   controller: headlineController,
//                   labelText: 'Headline',
//                   obscureText: false,
//                 ),
//                 SizedBox(height: 10.h),
//                 MyPostTextField(
//                   maxlines: 5,
//                   controller: contentController,
//                   labelText: 'Content',
//                   obscureText: false,
//                 ),
//                 SizedBox(height: 10.h),
//                 MyPostTextField(
//                   maxlines: 1,
//                   controller: addressController,
//                   labelText: 'Address',
//                   obscureText: false,
//                 ),
//                 SizedBox(height: 10.h),
//                 MyPostTextField(
//                   maxlines: 1,
//                   controller: contactController,
//                   labelText: 'Contact No.',
//                   obscureText: false,
//                 ),
//                 SizedBox(height: 10.h),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       width: 2.h,
//                       color: Theme.of(context).colorScheme.inversePrimary,
//                     ),
//                   ),
//                   child: Image.network(
//                     imageUrl,
//                     height: 200.0,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     // add the package image picker
//                     final file = await ImagePicker()
//                         .pickImage(source: ImageSource.gallery);
//                     if (file == null) return;
//                     String filename =
//                         DateTime.now().microsecondsSinceEpoch.toString();

//                     // creating the image folder and uploading image inside it
//                     Reference referenceRoot = FirebaseStorage.instance.ref();
//                     Reference referenceDireImages =
//                         referenceRoot.child('images');

//                     // creating the reference for the image to be stored
//                     Reference referenceImageToUpload =
//                         referenceDireImages.child(filename);

//                     // for error handling and success
//                     try {
//                       await referenceImageToUpload.putFile(File(file.path));

//                       // image is uploaded, now adding the image link to firebase database
//                       imageUrl = await referenceImageToUpload.getDownloadURL();
//                     } catch (error) {
//                       // handle errors
//                     }
//                   },
//                   icon: const Icon(Icons.add_a_photo),
//                 ),
//                 SizedBox(height: 10.h),
//                 MyButton(
//                   text: 'Submit',
//                   onTap: () async {
//                     submitButtonLogic(
//                       context: context,
//                       headline: headlineController.text,
//                       content: contentController.text,
//                       address: addressController.text,
//                       contact: contactController.text,
//                       postId: widget.postId,
//                       onUpdate: widget.onUpdate,
//                       headlineController: headlineController,
//                       contentController: contentController,
//                       addressController: addressController,
//                       contactController: contactController,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// void showError(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
// }

import 'dart:io';

import 'package:charity_management_admin/common/widgets/my_button.dart';
import 'package:charity_management_admin/features/posts/data/post_data/data_model.dart';
import 'package:charity_management_admin/features/posts/services/post_service.dart';
import 'package:charity_management_admin/features/posts/widgets/my_post_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditPostPage extends StatefulWidget {
  final PostDataModel postDataModel;

  final Function(Map<String, dynamic>)? onUpdate; // Make onUpdate optional

  const EditPostPage({
    super.key,
    required this.postDataModel,
    this.onUpdate,
  });

  @override
  State<EditPostPage> createState() => EditPostPageState();
}

class EditPostPageState extends State<EditPostPage> {
  late TextEditingController headlineController;
  late TextEditingController contentController;
  late TextEditingController addressController;
  late TextEditingController contactController;
  late TextEditingController imageUrlController;

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
                  text: 'Submit',
                  onTap: () async {
                    PostDataModel postDataModel = PostDataModel(
                      postId: widget.postDataModel.postId,
                      postHeadline: headlineController.text,
                      postContent: contentController.text,
                      postAddress: addressController.text,
                      postContact: contactController.text,
                      postImageUrl: postImageUrl,
                      postCreatedAt: widget.postDataModel.postCreatedAt,
                    );
                    await PostDataSource().updatePost(
                      postDataModel: postDataModel,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Post Updated')),
                    );
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
