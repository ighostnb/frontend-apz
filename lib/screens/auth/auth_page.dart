import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:frontend_apz/constants/helper.dart';
import 'package:frontend_apz/repositories/auth_repository.dart';
import 'package:frontend_apz/screens/auth/widgets/side_panel.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _email = '';
  String _password = '';
  AuthRepositoryImpl _authRepositoryImpl = AuthRepositoryImpl();

  final Color _panelColor = Color(0xff3557DC);
  final Color _pageColor = Color(0xff2841A8);
  bool _remeberMe = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _buildBody(width: width, heigth: heigth),
      backgroundColor: _pageColor,
    );
  }

  Widget _buildBody({double width, double heigth}) {
    return Center(
      child: Container(
        height: heigth / 1.5,
        width: width / 2,
        color: Colors.white,
        child: Row(
          children: [
            Helper.isHaveAccount ? _side(heigth: heigth) : _mainPart(),
            Helper.isHaveAccount ? _mainPart() : _side(heigth: heigth),
          ],
        ),
      ),
    );
  }

  Widget _mainPart() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 7,
            ),
            child: Text(
              Helper.isHaveAccount
                  ? 'Log in to Your Account'
                  : 'Sign Up for an Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 50,
              right: Helper.isHaveAccount
                  ? MediaQuery.of(context).size.width / 6.8
                  : MediaQuery.of(context).size.width / 6.8,
              bottom: 5,
            ),
            child: Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            child: TextField(
              onChanged: (value) => _email = value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
                hintText: 'Enter your email adress',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 25,
              right: Helper.isHaveAccount
                  ? MediaQuery.of(context).size.width / 7.5
                  : MediaQuery.of(context).size.width / 7.5,
              bottom: 5,
            ),
            child: Text(
              'Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            child: TextField(
              obscuringCharacter: '*',
              obscureText: true,
              onChanged: (value) => _password = value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                ),
                hintText: 'Enter your password',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 12,
              left: Helper.isHaveAccount
                  ? MediaQuery.of(context).size.width / 5.2
                  : MediaQuery.of(context).size.width / 12.2,
            ),
            child: Row(
              children: [
                Checkbox(
                  value: _remeberMe,
                  onChanged: (value) => setState(
                    () => _remeberMe = !_remeberMe,
                  ),
                ),
                Text(
                  'Remeber Me',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
            ),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 5.9,
              child: TextButton(
                onPressed: () {
                  if (EmailValidator.validate(_email) == true &&
                      _password.length > 7) {
                    Helper.isHaveAccount
                        ? _authRepositoryImpl.login(
                            username: _email,
                            password: _password,
                            rememberMe: _remeberMe,
                          )
                        : _authRepositoryImpl.createUser(
                            username: _email,
                            password: _password,
                            rememberMe: _remeberMe,
                          );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 2.3,
                          ),
                          child: Text('Enter correct email and password!'),
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  Helper.isHaveAccount ? 'LOG IN' : 'SIGN UP',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    _panelColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _side({double heigth}) {
    return Container(
      height: heigth,
      color: _panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SidePanel(
            headerText: Helper.isHaveAccount
                ? 'Don\'t have an Account Yet?'
                : 'Already Signed up?',
            text: Helper.isHaveAccount
                ? 'Click button to create account.'
                : 'Click button to log in to your account.',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextButton(
              onPressed: () => setState(
                () {
                  Helper.isHaveAccount = !Helper.isHaveAccount;
                  _remeberMe = false;
                },
              ),
              child: Text(
                Helper.isHaveAccount
                    ? '      SIGN UP       '
                    : '       LOG IN       ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
