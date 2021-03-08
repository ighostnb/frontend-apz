import 'dart:convert';

import 'package:frontend_apz/constants/url.dart';
import 'package:frontend_apz/database/database.dart';
import 'package:frontend_apz/models/device_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class DeviceRepository {
  Future<bool> addDevice({String deviceName, List<String> deviceParams});
  Future<bool> changeDeviceParams({List<String> deviceParams, String deviceId});
  Future<bool> deleteDevice({String deviceName});
  Future<List<DeviceModel>> getUserDevices();
  Future<List<DeviceModel>> getDeviceInfo({String deviceId});
}

class DeviceRepositoryImpl extends DeviceRepository {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<bool> addDevice({String deviceName, List<String> deviceParams}) async {
    try {
      final SharedPreferences prefs = await _prefs;

      final _headers = {
        'Content-type': 'application/json',
        'token':
            Database.token == null ? prefs.getString('token') : Database.token,
      };

      final _body = jsonEncode({
        'user_id': Database.id == null ? prefs.getString('id') : Database.id,
        'device_name': deviceName,
        'device_params': deviceParams,
      });

      final _response = await http.post(
        Url.addDevice,
        headers: _headers,
        body: _body,
      );

      if (_response.statusCode == 200) return true;

      return false;
    } catch (__) {
      return false;
    }
  }

  @override
  Future<bool> deleteDevice({String deviceName}) async {
    try {
      final SharedPreferences prefs = await _prefs;

      final _headers = {
        'Content-type': 'application/json',
        'token':
            Database.token == null ? prefs.getString('token') : Database.token,
        'device_name': deviceName,
        'id': Database.id == null ? prefs.getString('id') : Database.id,
      };

      final _response = await http.delete(
        Url.deleteDevice,
        headers: _headers,
      );

      if (_response.statusCode == 200) return true;

      return false;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> changeDeviceParams(
      {List<String> deviceParams, String deviceId}) async {
    try {
      final SharedPreferences prefs = await _prefs;

      final _headers = {
        'Content-type': 'application/json',
        'token':
            Database.token == null ? prefs.getString('token') : Database.token,
        'device_id': deviceId,
      };

      final _body = jsonEncode({
        'device_params': deviceParams,
      });

      final _response = await http.patch(
        Url.changeDeviceParams,
        headers: _headers,
        body: _body,
      );

      if (_response.statusCode == 200) return true;

      return false;
    } catch (__) {
      return false;
    }
  }

  @override
  Future<List<DeviceModel>> getDeviceInfo({String deviceId}) async {
    try {
      final SharedPreferences prefs = await _prefs;

      final _headers = {
        'Content-type': 'application/json',
        'token':
            Database.token == null ? prefs.getString('token') : Database.token,
        'device_id': deviceId,
      };

      final _response = await http.get(
        Url.getDeviceInfo,
        headers: _headers,
      );

      if (_response.statusCode == 200) {
        List<DeviceModel> deviceList = [];
        var data = jsonDecode(_response.body);
        for (var i in data) {
          DeviceModel deviceModel = DeviceModel(
            deviceName: i['device_name'],
            deviceParams: i['device_params'],
            id: i['id'],
          );

          deviceList.add(deviceModel);
        }

        return deviceList;
      }

      return [];
    } catch (__) {
      return [];
    }
  }

  @override
  Future<List<DeviceModel>> getUserDevices() async {
    try {
      final SharedPreferences prefs = await _prefs;

      final _headers = {
        'Content-type': 'application/json',
        'token':
            Database.token == null ? prefs.getString('token') : Database.token,
      };

      final _response = await http.get(
        Url.getUserDevices,
        headers: _headers,
      );

      if (_response.statusCode == 200) {
        var data = jsonDecode(_response.body);

        List<DeviceModel> deviceList = [];
        for (var i in data) {
          DeviceModel deviceModel = DeviceModel(
            deviceName: i['device_name'],
            deviceParams: i['device_params'],
            id: i['id'],
          );

          deviceList.add(deviceModel);
        }

        return deviceList;
      }

      return [];
    } catch (__) {
      return [];
    }
  }
}
