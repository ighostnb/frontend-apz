import 'package:flutter/material.dart';
import 'package:frontend_apz/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    void _authCheck() async {
      final SharedPreferences prefs = await _prefs;

      if (Database.id != null && Database.token != null)
        Navigator.pushReplacementNamed(context, '/home');

      if (prefs.getString('id') != null && prefs.getString('token') != null)
        Navigator.pushReplacementNamed(context, '/home');

      if (Database.id == null && prefs.getString('id') == null)
        Navigator.pushReplacementNamed(context, '/');
    }

    _authCheck();

    return Container();
  }
}
