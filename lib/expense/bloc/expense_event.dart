part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class LoadExpensesEvent extends ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  final Expense expense;

  const AddExpenseEvent(this.expense);
  
  @override
  List<Object> get props => [expense];

  @override toString() => 'AddExpenseEvent { expense: $expense }';
}

class UpdateExpenseEvent extends ExpenseEvent {
  final Expense expense;

  const UpdateExpenseEvent(this.expense);

  @override
  List<Object> get props => [expense];

  @override
  toString() => 'UpdateExpenseEvent { expense: $expense }';
}

class RemoveExpenseEvent extends ExpenseEvent {
  final Expense expense;

  const RemoveExpenseEvent(this.expense);

  @override
  List<Object> get props => [expense];

  @override
  toString() => 'RemoveExpenseEvent { expense: $expense }';
}

class ExpensesUpdatedEvent extends ExpenseEvent {
  final List<Expense> expenses;

  const ExpensesUpdatedEvent(this.expenses);

  @override
  List<Object> get props => [expenses];
}


