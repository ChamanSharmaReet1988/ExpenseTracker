import 'package:flutter/material.dart';
import 'package:expense_tracker/Database/budget_table.dart';
import 'package:expense_tracker/Database/expense_table.dart';
import 'package:expense_tracker/Utility/preferences_helper.dart';
import 'package:expense_tracker/Views/LoginScreen/login_view.dart';

class Common {
  static void deleteTables() {
    ExpenseTable expenseTable = ExpenseTable();
    expenseTable.deleteTable();

    BudgetTable budgetTable = BudgetTable();
    budgetTable.deleteTable();
  }

  static void logout(BuildContext context) {
    PreferencesHelper prefs = PreferencesHelper();
    prefs.isLoggedIn = 0;
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  static void deleteAccount(BuildContext context) {
    PreferencesHelper prefs = PreferencesHelper();
    prefs.isLoggedIn = 0;
    deleteTables();
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
