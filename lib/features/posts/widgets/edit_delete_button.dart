import 'package:flutter/material.dart';

class EditDeleteButtons extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const EditDeleteButtons({
    required this.onEditPressed,
    required this.onDeletePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: onEditPressed,
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.inversePrimary,
            onPrimary: Theme.of(context).colorScheme.primary,
          ),
          child: Text('Edit'),
        ),
        SizedBox(width: 16.0),
        ElevatedButton(
          onPressed: onDeletePressed,
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.error,
            onPrimary: Theme.of(context).colorScheme.onError,
          ),
          child: Text('Delete'),
        ),
      ],
    );
  }
}
