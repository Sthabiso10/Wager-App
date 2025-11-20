import 'package:flutter/material.dart';
import '../../../styles/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: colorAccent,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Settings Page',
          style: TextStyle(
            color: colorText,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
