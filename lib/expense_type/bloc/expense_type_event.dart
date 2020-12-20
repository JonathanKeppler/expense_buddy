part of 'expense_type_bloc.dart';

abstract class ExpenseTypeEvent extends Equatable {
  const ExpenseTypeEvent();

  @override
  List<Object> get props => [];
}

class LoadExpenseTypesEvent extends ExpenseTypeEvent {}

class AddExpenseTypeEvent extends ExpenseTypeEvent {
  final ExpenseType expenseType;

  const AddExpenseTypeEvent(this.expenseType);
  
  @override
  List<Object> get props => [expenseType];

  @override toString() => 'AddExpenseTypeEvent { expense: $expenseType }';
}

class UpdateExpenseTypeEvent extends ExpenseTypeEvent {
  final ExpenseType expenseType;

  const UpdateExpenseTypeEvent(this.expenseType);

  @override
  List<Object> get props => [expenseType];

  @override
  toString() => 'UpdateExpenseTypeEvent { expense: $expenseType }';
}

class RemoveExpenseTypeEvent extends ExpenseTypeEvent {
  final ExpenseType expenseType;

  const RemoveExpenseTypeEvent(this.expenseType);

  @override
  List<Object> get props => [expenseType];

  @override
  toString() => 'RemoveExpenseTypeEvent { expense: $expenseType }';
}

class ExpenseTypesUpdatedEvent extends ExpenseTypeEvent {
  final List<ExpenseType> expenseTypes;

  const ExpenseTypesUpdatedEvent(this.expenseTypes);

  @override
  List<Object> get props => [expenseTypes];
}


