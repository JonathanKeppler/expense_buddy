import 'dart:async';

import 'models/models.dart';

abstract class ExpenseTypeSubTypeRepository {
  Future<void> addExpenseTypeSubType(ExpenseTypeSubType expenseTypeSubType, String parentDoc);

  Future<void> removeExpenseTypeSubType(ExpenseTypeSubType expenseTypeSubType, String parentDoc);

  Future<void> updateExpenseTypeSubType(ExpenseTypeSubType expenseTypeSubType, String parentDoc);

  Stream<List<ExpenseTypeSubType>> expenseTypeSubTypes(String parentDoc);
}