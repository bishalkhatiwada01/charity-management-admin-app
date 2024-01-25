import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Text text;
  const MyAppBar({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      title: Text(
        text.data!,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          letterSpacing: 4,
        ),
      ),
      centerTitle: true,
    );
  }
}
