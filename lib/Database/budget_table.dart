import 'package:sqflite/sqflite.dart';
import 'package:expense_tracker/Database/database.dart';
import 'package:expense_tracker/Models/budget_model.dart';

class BudgetTable {
  Future<int> insertItemIntoBudget(Budget budget) async {
    try {
      return await DatabaseHelper.database?.insert(
            'BudgetTable',
            budget.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          ) ??
          0;
    } catch (e) {
      // Print the error message
      print('Error inserting item into BudgetTable: $e');
      return 0;
    }
  }

  Future<List<Budget>> getBudgetData() async {
    String query = 'SELECT * FROM BudgetTable';
    final List<Map<String, dynamic>> maps =
        await DatabaseHelper.database?.rawQuery(query) ?? List.empty();
    return List.generate(maps.length, (i) {
      return Budget.fromMap(maps[i]);
    });
  }

  Future<void> deleteTable() async {
    await DatabaseHelper.database?.execute('Delete from BudgetTable');
  }

  Future<bool> hasRecords() async {
    const countQuery = 'SELECT COUNT(*) FROM BudgetTable';
    final count = await DatabaseHelper.database?.rawQuery(countQuery);
    return ((count?.first.values.first as int) > 0);
  }
}
