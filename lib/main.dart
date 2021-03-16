import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_apz/blocs/device/device_cubit.dart';
import 'package:frontend_apz/repositories/device_repository.dart';
import 'package:frontend_apz/screens/auth/auth_page.dart';
import 'package:frontend_apz/screens/home/home_page.dart';
import 'package:frontend_apz/screens/menu-panel/menu_panel.dart';

import 'utils/auth_check.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeviceCubit>(
          create: (context) => DeviceCubit(DeviceRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'BetmRounded',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthCheck(),
          '/auth': (context) => AuthPage(),
          '/home': (context) => MenuPanel(),
        },
      ),
    );
  }
}
