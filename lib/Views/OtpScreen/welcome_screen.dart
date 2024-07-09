import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/Utility/constant.dart';
import 'package:expense_tracker/Models/budget_model.dart';
import 'package:expense_tracker/Database/budget_table.dart';
import 'package:expense_tracker/Utility/preferences_helper.dart';
import 'package:expense_tracker/Views/TabBarScreen/tab_bar_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  final TextEditingController _budgetController = TextEditingController();
  String selectedCurrencyCode = 'INR';

  @override
  void initState() {
    super.initState();
  }

  void _saveMethod(BuildContext context) {
    PreferencesHelper prefs = PreferencesHelper();
    prefs.currency = selectedCurrencyCode;
    prefs.isLoggedIn = 2;

    DateTime now = DateTime.now();
    BudgetTable budgetTable = BudgetTable();
    Budget myBudget = Budget(
      id: 1,
      title: "Budget",
      year: "${now.year}",
      month: "${now.month}",
      day: "${now.day}",
      time: DateFormat('HH:mm:ss').format(now),
      amount: _budgetController.text,
    );
    budgetTable.insertItemIntoBudget(myBudget);

    final String budgetAmount = _budgetController.text;
    if (budgetAmount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Budget is mandatory to fill'),
            backgroundColor: Colors.red),
      );
      return;
    }

    final int? budgetValue = int.tryParse(budgetAmount);
    if (budgetValue == null || budgetValue <= 1000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Budget amount must be greater than 1000.'),
            backgroundColor: Colors.red),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TabBarScreen()),
    );
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
                  "Let's set your income and currency",
                  style: TextStyle(
                    fontSize: 29,
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
            const SizedBox(height: 26),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 60,
                      child: DropdownButtonFormField<String>(
                        value: selectedCurrencyCode,
                        items: Constant.currencyCodes.map((String code) {
                          return DropdownMenuItem<String>(
                            value: code,
                            child: Text(code),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCurrencyCode = newValue!;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Currency',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )),
                const SizedBox(width: 10),
                Expanded(
                    flex: 5,
                    child: SizedBox(
                        height: 60,
                        child: TextField(
                          controller: _budgetController,
                          decoration: const InputDecoration(
                            // labelText: 'Enter your text',
                            hintText: 'Enter Income',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType
                              .number, // Set keyboard type to number
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly // Only allows input of digits
                          ],
                          onChanged: (value) {
                            // Handle changes to the text field input
                          },
                        )))
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _saveMethod(context),
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
