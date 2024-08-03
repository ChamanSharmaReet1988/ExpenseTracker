import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _currency = 'USD';
  String _language = 'English';
  String _theme = 'Dark';
  String _security = 'Fingerprint';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Currency'),
            trailing: DropdownButton(
              value: _currency,
              onChanged: (value) {
                setState(() {
                  _currency = value ?? "";
                });
              },
              items: [
                DropdownMenuItem(
                  child: Text('USD'),
                  value: 'USD',
                ),
                DropdownMenuItem(
                  child: Text('EUR'),
                  value: 'EUR',
                ),
                // Add more currencies as needed
              ],
            ),
          ),
          ListTile(
            title: Text('About'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to about screen
            },
          ),
          ListTile(
            title: Text('Help'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to help screen
            },
          ),
        ],
      ),
    );
  }
}
