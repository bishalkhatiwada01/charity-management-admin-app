// display error  messageto the user

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void displayMessageToUser(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    ),
  );
}
