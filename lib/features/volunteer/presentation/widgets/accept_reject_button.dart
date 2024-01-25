import 'package:flutter/material.dart';

class AcceptRejectButtons extends StatelessWidget {
  final VoidCallback onAcceptPressed;
  final VoidCallback onRejectPressed;

  const AcceptRejectButtons({
    required this.onAcceptPressed,
    required this.onRejectPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: onAcceptPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: const Text('Accept'),
        ),
        const SizedBox(width: 16.0),
        ElevatedButton(
          onPressed: onRejectPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onError,
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
          child: const Text('Reject'),
        ),
      ],
    );
  }
}
