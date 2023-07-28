import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  final String message;
  final Function() onPressed;

  const RetryWidget({
    super.key,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(message),
        const SizedBox(height: 8.0),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'Retry',
            style: TextStyle(
              color: Color(0xFF3366CC),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
