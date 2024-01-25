import 'package:flutter/material.dart';

class LabelValueWidget extends StatelessWidget {
  final String label;
  final String value;

  LabelValueWidget({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ],
      ),
    );
  }
}
