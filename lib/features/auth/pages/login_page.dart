// ignore_for_file: use_build_context_synchronously

import 'package:charity_management_admin/common/widgets/my_button.dart';
import 'package:charity_management_admin/common/widgets/my_textfield.dart';
import 'package:charity_management_admin/features/auth/data/auth_service.dart';
import 'package:charity_management_admin/features/auth/pages/forgot_password_page.dart';
import 'package:charity_management_admin/features/auth/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({
    super.key,
    required void Function() onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthService _authService = AuthService();
  final formKey = GlobalKey<FormState>();
  // text controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<void> _login() async {

    await _authService.login(
      emailController.text,
      passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      backgroundColor: Theme.of(context).colorScheme.background,

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25.sp),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 80,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  Text(
                    'Welcome Back!!',
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 45.h),
                  MyTextField(
                    hintText: 'Email',
                    obscureText: false,
                    controller: emailController,
                  ),
                  SizedBox(height: 25.h),
                  MyTextField(
                    hintText: 'Password',
                    obscureText: true,
                    controller: passwordController,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordPage()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  MyButton(
                    text: 'Login',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await _login();
                      }
                    },
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage(
                                        onTap: () {},
                                      )));
                        },
                        child: const Text('Register Here',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
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
