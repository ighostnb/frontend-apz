import 'package:flutter/material.dart';
import 'package:frontend_apz/database/database.dart';
import 'package:frontend_apz/screens/device/device_page.dart';
import 'package:frontend_apz/screens/home/home_page.dart';
import 'package:frontend_apz/screens/monitoring/monitor_page.dart';
import 'package:frontend_apz/screens/settings/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPanel extends StatefulWidget {
  @override
  _MenuPanelState createState() => _MenuPanelState();
}

class _MenuPanelState extends State<MenuPanel> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final List<Widget> _screensList = [
    HomePage(),
    DevicePage(),
    MonitorPage(),
    SettingsPage(),
  ];

  final double _iconSize = 45;

  final Color _activeColor = Color(0xff3557DC);
  final Color _inactiveColor = Colors.grey;

  final PageStorageBucket _pageStorageBucket = PageStorageBucket();

  int _selectedItem = 0;

  Widget _currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: _pageStorageBucket,
        child: _currentScreen,
      ),
      drawer: Container(
        child: Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width / 1.03,
          ),
          child: SingleChildScrollView(child: _menu()),
        ),
      ),
    );
  }

  Widget _menu() {
    return Column(
      children: [
        GestureDetector(
          child: Icon(
            Icons.home,
            color: _selectedItem == 0 ? _activeColor : _inactiveColor,
            size: _iconSize,
          ),
          onTap: () => setState(() {
            _currentScreen = _screensList[0];
            _selectedItem = 0;
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: GestureDetector(
            child: Icon(
              Icons.devices,
              color: _selectedItem == 1 ? _activeColor : _inactiveColor,
              size: _iconSize,
            ),
            onTap: () => setState(() {
              _currentScreen = _screensList[1];
              _selectedItem = 1;
            }),
          ),
        ),
        GestureDetector(
          child: Icon(
            Icons.remove_red_eye,
            color: _selectedItem == 2 ? _activeColor : _inactiveColor,
            size: _iconSize,
          ),
          onTap: () => setState(() {
            _currentScreen = _screensList[2];
            _selectedItem = 2;
          }),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: GestureDetector(
            child: Icon(
              Icons.settings,
              color: _selectedItem == 3 ? _activeColor : _inactiveColor,
              size: _iconSize,
            ),
            onTap: () => setState(() {
              _currentScreen = _screensList[3];
              _selectedItem = 3;
            }),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 1.5,
          ),
          child: GestureDetector(
            child: Icon(
              Icons.exit_to_app,
              color: _inactiveColor,
              size: _iconSize,
            ),
            onTap: () async {
              final SharedPreferences prefs = await _prefs;

              Database.id = null;
              Database.token = null;

              prefs.remove('id');
              prefs.remove('token');

              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ),
      ],
    );
  }
}
