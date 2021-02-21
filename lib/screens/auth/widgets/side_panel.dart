import 'package:flutter/material.dart';

class SidePanel extends StatelessWidget {
  final Color _textColor = Colors.white;
  final String headerText;
  final String text;

  SidePanel({this.headerText, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              headerText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: _textColor,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(color: _textColor),
          ),
        ],
      ),
    );
  }
}
