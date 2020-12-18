part of 'expense_bloc.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();
  
  @override
  List<Object> get props => [];
}

class ExpensesLoadingState extends ExpenseState {}

class ExpensesLoadedState extends ExpenseState {
  final List<Expense> expenses;

  const ExpensesLoadedState([this.expenses = const []]);

  @override
  List<Object> get props => [expenses];

  @override
  toString() => 'ExpensesLoadedState { expenses: $expenses }';
}

class ExpensesNotLoadedState extends ExpenseState {}
