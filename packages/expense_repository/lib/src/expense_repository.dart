import 'dart:async';

import 'models/expense.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(Expense expense);

  Future<void> removeExpense(Expense expense);

  Future<void> updateExpense(Expense expense);

  Stream<List<Expense>> expenses();
}