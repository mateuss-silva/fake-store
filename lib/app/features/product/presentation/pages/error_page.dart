import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/connection-error.png',
                width: 200,
                height: 200,
              ),
              const Text(
                'Something went wrong!',
                style: TextStyle(
                  color: Color(0xA537474F),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Align(
            child: TextButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: const Text(
                'Go Home',
                style: TextStyle(
                  color: Color(0xFF3366CC),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ));
  }
}
