import 'package:flutter/material.dart';
import 'package:expense_tracker/HomeScreen/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // ignore: deprecated_member_use
        body: WillPopScope(
      onWillPop: () async {
        // Handle back button press
        return false; // Return true to allow back navigation, false to prevent it
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80), // Add some top padding
                Text(
                  "Let's setup your account!",
                  style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Account can be your bank, credit card or your wallet.",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7F3DFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              ),
              child: const Center(
                child: Text(
                  "Let's go",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ));
  }
}
