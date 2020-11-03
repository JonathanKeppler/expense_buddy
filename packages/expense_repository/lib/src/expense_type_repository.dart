import 'dart:async';

import 'models/models.dart';

abstract class ExpenseTypeRepository {
  Future<void> addExpenseType(ExpenseType expenseType);

  Future<void> removeExpenseType(ExpenseType expenseType);

  Future<void> updateExpenseType(ExpenseType expenseType);

  Stream<List<ExpenseType>> expenseTypes();
}