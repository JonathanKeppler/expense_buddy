part of 'expense_type_bloc.dart';

abstract class ExpenseTypeEvent extends Equatable {
  const ExpenseTypeEvent();

  @override
  List<Object> get props => [];
}

class LoadExpenseTypesEvent extends ExpenseTypeEvent {}

class AddExpenseTypeEvent extends ExpenseTypeEvent {
  final ExpenseType expense;

  const AddExpenseTypeEvent(this.expense);
  
  @override
  List<Object> get props => [expense];

  @override toString() => 'AddExpenseEvent { expense: $expense }';
}

class UpdateExpenseTypeEvent extends ExpenseTypeEvent {
  final ExpenseType expense;

  const UpdateExpenseTypeEvent(this.expense);

  @override
  List<Object> get props => [expense];

  @override
  toString() => 'UpdateExpenseEvent { expense: $expense }';
}

class RemoveExpenseTypeEvent extends ExpenseTypeEvent {
  final ExpenseType expense;

  const RemoveExpenseTypeEvent(this.expense);

  @override
  List<Object> get props => [expense];

  @override
  toString() => 'RemoveExpenseEvent { expense: $expense }';
}

class ExpenseTypesUpdatedEvent extends ExpenseTypeEvent {
  final List<ExpenseType> expenses;

  const ExpenseTypesUpdatedEvent(this.expenses);

  @override
  List<Object> get props => [expenses];
}


