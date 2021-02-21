import 'package:flutter/material.dart';
import 'package:frontend_apz/screens/auth/auth_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'BetmRounded',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthPage(),
      },
    );
  }
}
