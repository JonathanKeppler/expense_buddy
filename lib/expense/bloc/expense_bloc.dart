import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository _expenseRepository;
  StreamSubscription _expenseSubscription;

  ExpenseBloc({@required ExpenseRepository expenseRepository})
   : assert(expenseRepository != null),
   _expenseRepository = expenseRepository,
   super(ExpensesLoadingState());

  @override
  Stream<ExpenseState> mapEventToState(ExpenseEvent event) async* {
    if (event is LoadExpensesEvent) {
      yield* _mapLoadExpensesToState();
    } else if (event is AddExpenseEvent) {
      yield* _mapAddExpenseEventToState(event);
    } else if (event is UpdateExpenseEvent) {
      yield* _mapUpdateExpenseEventToState(event);
    } else if (event is RemoveExpenseEvent) {
      yield* _mapRemoveExpenseEventToState(event);
    } else if (event is ExpensesUpdatedEvent) {
      yield* _mapExpensesUpdatedEventToState(event);
    }
  }

  Stream<ExpenseState> _mapLoadExpensesToState() async* {
    _expenseSubscription?.cancel();
    _expenseSubscription = _expenseRepository.expenses().listen(
      (expenses) => add(ExpensesUpdatedEvent(expenses))
    );
  }

  Stream<ExpenseState> _mapAddExpenseEventToState(AddExpenseEvent event) async* {
    _expenseRepository.addExpense(event.expense);
  }

  Stream<ExpenseState> _mapUpdateExpenseEventToState(UpdateExpenseEvent event) async* {
    _expenseRepository.updateExpense(event.expense);
  }

  Stream<ExpenseState> _mapRemoveExpenseEventToState(RemoveExpenseEvent event) async* {
    _expenseRepository.removeExpense(event.expense);
  }

  Stream<ExpenseState> _mapExpensesUpdatedEventToState(ExpensesUpdatedEvent event) async* {
    yield ExpensesLoadedState(event.expenses);
  }

  @override
  Future<void> close() {
    _expenseSubscription?.cancel();
    return super.close();
  }
}
