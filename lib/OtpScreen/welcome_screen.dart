import 'package:flutter/material.dart';
import 'package:expense_tracker/HomeScreen/home_screen.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
    void _saveBudget() {
    final String budgetAmount = _budgetController.text;

    if (budgetAmount.isNotEmpty ) {
      // Perform your save logic here
      print('Budget Amount: $budgetAmount');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Budget saved successfully!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a budget amount and purpose.'),
      ));
    }
    }

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
                  "Let's add your current Month's Budget",
                  style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "You can more efficiently plan and control your spending when you have a budget. You can monitor your spending and make sure your financial objectives are met by creating a monthly budget.",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 26),
            TextField(
              decoration: InputDecoration(
                // labelText: 'Enter your text',
                hintText: 'Budget Amount...',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number, // Set keyboard type to number
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly // Only allows input of digits
              ],
              onChanged: (value) {
                // Handle changes to the text field input
                print('Input value: $value');
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _isButtonEnabled ? _saveBudget : null,
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
