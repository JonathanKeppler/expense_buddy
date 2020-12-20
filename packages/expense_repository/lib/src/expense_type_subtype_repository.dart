import 'dart:async';

import 'models/models.dart';
import 'package:authentication_repository/authentication_repository.dart';

abstract class ExpenseTypeSubTypeRepository {
  Future<void> addExpenseTypeSubType(
    AuthUser authUser,
    ExpenseType expenseType,
    ExpenseTypeSubType expenseTypeSubType);

  Future<void> removeExpenseTypeSubType(
    AuthUser authUser,
    ExpenseType expenseType,
    ExpenseTypeSubType expenseTypeSubType);

  Future<void> updateExpenseTypeSubType(
    AuthUser authUser,
    ExpenseType expenseType,
    ExpenseTypeSubType expenseTypeSubType);

  Stream<List<ExpenseTypeSubType>> expenseTypeSubTypes(
    AuthUser authUser,
    ExpenseType expenseType);
}