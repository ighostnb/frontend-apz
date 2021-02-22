import 'dart:convert';

import 'package:frontend_apz/constants/const.dart';
import 'package:frontend_apz/database/database.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future<bool> createUser({String email, String password, bool rememberMe});
  Future<bool> login({String email, String password, bool rememberMe});
  Future<bool> deleteUser({String id, String token});
}

class AuthRepositoryImpl extends AuthRepository {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<bool> createUser(
      {String email, String password, bool rememberMe}) async {
    try {
      final _headers = {
        'Content-type': 'application/json',
      };

      final _body = jsonEncode({
        'email': email,
        'password': password,
      });

      final _response = await http.post(
        Const.registerUrl,
        body: _body,
        headers: _headers,
      );

      print(_response.statusCode);

      if (_response.statusCode == 200) {
        // login(
        //   email: email,
        //   password: password,
        //   rememberMe: rememberMe,
        // );
        return true;
      }

      return false;
    } catch (__) {
      print(__.toString() + 'asda');
      return false;
    }
  }

  @override
  Future<bool> login({String email, String password, bool rememberMe}) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final _headers = {
        'Content-type': 'application/json',
      };

      final _body = jsonEncode({
        'email': email,
        'password': password,
      });

      final _response = await http.post(
        Const.loginUrl,
        body: _body,
        headers: _headers,
      );

      if (_response.statusCode == 200) {
        final data = jsonDecode(_response.body);
        if (rememberMe) {
          prefs.setString('id', data['id']);
          prefs.setString('token', data['token']);
        } else {
          Database.id = data['id'];
          Database.token = data['token'];
        }
        return true;
      }

      return false;
    } catch (__) {
      print(__.toString());
      return false;
    }
  }

  @override
  Future<bool> deleteUser({String id, String token}) async {
    try {
      final _headers = {
        'Content-type': 'application/json',
        'id': id,
        'token': token,
      };

      final _response = await http.delete(
        Const.deleteUserUrl,
        headers: _headers,
      );

      if (_response.statusCode == 200) return true;

      return false;
    } catch (__) {
      print(__.toString());
      return false;
    }
  }
}
