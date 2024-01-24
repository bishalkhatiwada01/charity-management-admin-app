import 'package:charity_management_admin/common/widgets/my_back_buttom.dart';
import 'package:charity_management_admin/common/widgets/my_button.dart';
import 'package:charity_management_admin/common/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // String _message = "";
  // void _resetPassword() async {
  //   try {
  //     await _auth.sendPasswordResetEmail(email: _emailController.text);
  //     setState(() {
  //       _message = "Password reset email sent. Check your email.";
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _message = "Error: ${e.toString()}";
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const MyBackButton(),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "The verification code will be sent to this email address",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.normal,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyTextField(
                      hintText: 'example@gmail.com',
                      obscureText: false,
                      controller: _emailController),
                  SizedBox(height: 20.h),
                  MyButton(
                    text: 'Continue',
                    onTap: () {},
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
