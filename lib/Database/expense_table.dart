import 'package:sqflite/sqflite.dart';
import 'package:expense_tracker/Database/database.dart';
import 'package:expense_tracker/Models/expense_model.dart';

class ExpenseTable {
  Future<int> insertItemIntoExpenseTable(Expense expense) async {
    return await DatabaseHelper.database?.insert(
          'ExpenseTable',
          expense.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ) ??
        0;
  }

  Future<List<Expense>> getExpenseData() async {
    String query = 'SELECT * FROM ExpenseTable';
    final List<Map<String, dynamic>> maps =
        await DatabaseHelper.database?.rawQuery(query) ?? List.empty();
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  Future<void> deleteTable() async {
    await DatabaseHelper.database?.execute('Delete from ExpenseTable');
  }
}
