import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPostTextField extends StatelessWidget {
  final String labelText;
  final int maxlines;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator; // Validator function

  const MyPostTextField({
    super.key,
    required this.labelText,
    required this.maxlines,
    required this.obscureText,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).colorScheme.inversePrimary,
      maxLines: maxlines,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
