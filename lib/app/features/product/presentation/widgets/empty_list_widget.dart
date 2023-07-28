import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/empty-list.png',
          height: 200,
          width: 200,
        ),
        const Text(
          'The list is empty',
          style: TextStyle(
            color: Color(0xA537474F),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
