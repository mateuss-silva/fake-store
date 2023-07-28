import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Fake Store',
      theme: ThemeData(
        primarySwatch: colorTheme,
        useMaterial3: true,
      ),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}

MaterialColor colorTheme = const MaterialColor(0xFFF37A20, {
  50: Color.fromRGBO(243, 122, 32, .05),
  100: Color.fromRGBO(243, 122, 32, .1),
  200: Color.fromRGBO(243, 122, 32, .2),
  300: Color.fromRGBO(243, 122, 32, .3),
  400: Color.fromRGBO(243, 122, 32, .4),
  500: Color.fromRGBO(243, 122, 32, .5),
  600: Color.fromRGBO(243, 122, 32, .6),
  700: Color.fromRGBO(243, 122, 32, .7),
  800: Color.fromRGBO(243, 122, 32, .8),
  900: Color.fromRGBO(243, 122, 32, .9),
});
