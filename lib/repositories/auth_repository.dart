import 'dart:convert';

import 'package:frontend_apz/constants/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future<void> createUser({String username, String password});
  Future<void> login({String username, String password});
  Future<void> deleteUser({String id, String token});
}

class AuthRepositoryImpl extends AuthRepository {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> createUser({String username, String password}) async {
    try {
      final _headers = {
        'Content-type': 'application/json',
      };

      final _body = jsonEncode({
        'username': username,
        'password': password,
      });

      final _response = await http.post(
        Const.registerUrl,
        body: _body,
        headers: _headers,
      );

      if (_response.statusCode == 200) {
        login(username: username, password: password);
      }
    } catch (__) {
      print(__.toString());
    }
  }

  @override
  Future<void> deleteUser({String id, String token}) async {
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

      if (_response.statusCode == 200) {}
    } catch (__) {
      print(__.toString());
    }
  }

  @override
  Future<void> login({String username, String password}) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final _headers = {
        'Content-type': 'application/json',
      };

      final _body = jsonEncode({
        'username': username,
        'password': password,
      });

      final _response = await http.post(
        Const.loginUrl,
        body: _body,
        headers: _headers,
      );

      if (_response.statusCode == 200) {
        final data = jsonDecode(_response.body);
        prefs.setString('id', data['id']);
        prefs.setString('token', data['token']);
      }
    } catch (__) {
      print(__.toString());
    }
  }
}
