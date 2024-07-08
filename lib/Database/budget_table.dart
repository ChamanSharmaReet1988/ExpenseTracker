import 'package:sqflite/sqflite.dart';
import 'package:expense_tracker/Database/database.dart';
import 'package:expense_tracker/Models/budget_model.dart';

class BudgetTable {
  Future<int> insertItemIntoBudget(Budget budget) async {
    return await DatabaseHelper.database?.insert(
          'BudgetTable',
          budget.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ) ??
        0;
  }

  Future<List<Budget>> getBudgetData() async {
    String query = 'SELECT * FROM BudgetTable';
    final List<Map<String, dynamic>> maps =
        await DatabaseHelper.database?.rawQuery(query) ?? List.empty();
    return List.generate(maps.length, (i) {
      return Budget.fromMap(maps[i]);
    });
  }
}
