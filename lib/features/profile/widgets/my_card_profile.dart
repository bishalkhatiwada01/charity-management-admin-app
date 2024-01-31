import 'package:flutter/material.dart';

class MyCardProfile extends StatelessWidget {
  final String title;
  final Widget leading;
  final VoidCallback onPressed;

  const MyCardProfile({
    Key? key,
    required this.title,
    required this.leading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Icon(
          Icons.privacy_tip_sharp,
          color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.8),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color:
                Theme.of(context).colorScheme.inversePrimary.withOpacity(0.8),
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
            color:
                Theme.of(context).colorScheme.inversePrimary.withOpacity(0.8),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
