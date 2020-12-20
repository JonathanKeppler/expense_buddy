part of 'expense_type_bloc.dart';

abstract class ExpenseTypeState extends Equatable {
  const ExpenseTypeState();
  
  @override
  List<Object> get props => [];
}

class ExpenseTypesLoadingState extends ExpenseTypeState {}

class ExpenseTypesLoadedState extends ExpenseTypeState {
  final List<ExpenseType> expenseTypes;

  const ExpenseTypesLoadedState([this.expenseTypes = const []]);

  @override
  List<Object> get props => [expenseTypes];

  @override
  toString() => 'ExpenseTypesLoadedState { expenseTypes: $expenseTypes }';
}

class ExpenseTypesNotLoadedState extends ExpenseTypeState {}
