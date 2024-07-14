import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:expense_tracker/Database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/Utility/preferences_helper.dart';
import 'package:expense_tracker/Views/LoginScreen/login_view.dart';
import 'package:expense_tracker/Views/OtpScreen/welcome_screen.dart';
import 'package:expense_tracker/Views/TabBarScreen/tab_bar_screen.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// ignore: file_names

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.open();

  PreferencesHelper prefsHelper = PreferencesHelper();
  await prefsHelper.init();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<int> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('isLoggedIn') ?? 0;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<int>(
        future: checkLogin(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            if (snapshot.data == 0) {
              return const LoginPage();
            } else if (snapshot.data == 1) {
              return const WelcomeScreen();
            } else {
              return const TabBarScreen();
            }
          }
        },
      ),
    ));
  }
}
