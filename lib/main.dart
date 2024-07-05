import 'package:expense_tracker/TabBarScreen/tab_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:expense_tracker/Database/database.dart';
import 'package:expense_tracker/LoginScreen/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: file_names

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.open();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});
    
  Future<bool> checkLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

Future<bool> checkLoginFirstorNot() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedInFirst') ?? false;
}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: checkLogin(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
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
            bool isLoggedIn = snapshot.data ?? false;
            return isLoggedIn ? const TabBarScreen() : const LoginPage();
          }
        },
      ),
    );

  }
}
