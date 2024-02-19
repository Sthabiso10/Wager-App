import 'package:flutter/material.dart';
import '../themes/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.backGroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyAppColors.accentColor,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Settings Page',
          style: TextStyle(
            color: MyAppColors.textColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
