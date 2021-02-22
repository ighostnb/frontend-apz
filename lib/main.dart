import 'package:flutter/material.dart';
import 'package:frontend_apz/screens/auth/auth_page.dart';
import 'package:frontend_apz/screens/home/home_page.dart';

import 'utils/auth_check.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'BetmRounded',
      ),
      initialRoute: '/auth',
      routes: {
        '/': (context) => AuthPage(),
        '/auth': (context) => AuthCheck(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
