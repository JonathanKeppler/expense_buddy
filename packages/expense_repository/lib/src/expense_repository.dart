import 'dart:async';

import 'models/models.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(Expense expense);

  Future<void> removeExpense(Expense expense);

  Future<void> updateExpense(Expense expense);

  Stream<List<Expense>> expenses();
}