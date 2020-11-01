import 'dart:async';

import 'models/models.dart';

abstract class ExpenseTypeRepository {
  Future<void> addExpenseType(ExpenseType expense);

  Future<void> removeExpenseType(ExpenseType expense);

  Future<void> updateExpenseType(ExpenseType expense);

  Stream<List<ExpenseType>> expenseTypes();
}