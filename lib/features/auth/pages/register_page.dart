import 'package:charity_management_admin/common/widgets/my_button.dart';
import 'package:charity_management_admin/common/widgets/my_textfield.dart';
import 'package:charity_management_admin/features/auth/pages/login_page.dart';
import 'package:charity_management_admin/features/dashbord/views/home_page.dart';
import 'package:charity_management_admin/helper/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPwController = TextEditingController();

  // login method
  void registerUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure password match
    if (passwordController.text != confirmPwController.text) {
      Navigator.pop(context);

      // show error message to user
      displayMessageToUser('Password dont match', context);
    }
    // if the password match
    else {
      // try creating the user
      try {
        // create the user
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // create the user document and add to firestore
        createUserDocument(userCredential);
        // pop loading circle
        if (context.mounted) Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);

        // display error message
        displayMessageToUser(e.code, context);
      }
    }
  }

  // create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("admin_users")
          .doc(userCredential.user!.uid)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginPage(
                      onTap: () {},
                    )));
          },
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            padding: EdgeInsets.all(10.sp),
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.sp),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Icon
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                // name of app
                Text(
                  '''Let's Get Started!!!''',
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 25.h),

                // username textfield
                MyTextField(
                  hintText: 'Username',
                  obscureText: false,
                  controller: usernameController,
                ),
                SizedBox(height: 10.h),

                // email textfield
                MyTextField(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController,
                ),
                SizedBox(height: 10.h),

                // password textfield
                MyTextField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(height: 10.h),

                // confirm password textfield
                MyTextField(
                  hintText: 'Confirm Password',
                  obscureText: true,
                  controller: confirmPwController,
                ),
                SizedBox(height: 10.h),

                // register button
                MyButton(
                  text: 'Register',
                  onTap: registerUser,
                ),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
