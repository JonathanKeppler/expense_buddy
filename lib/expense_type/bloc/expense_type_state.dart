part of 'expense_type_bloc.dart';

abstract class ExpenseTypeState extends Equatable {
  const ExpenseTypeState();
  
  @override
  List<Object> get props => [];
}

class ExpenseTypesLoadingState extends ExpenseTypeState {}

class ExpenseTypesLoadedState extends ExpenseTypeState {
  final List<ExpenseType> expenses;

  const ExpenseTypesLoadedState([this.expenses = const []]);

  @override
  List<Object> get props => [expenses];

  @override
  toString() => 'ExpenseTypesLoadedState { expenses: $expenses }';
}

class ExpenseTypesNotLoadedState extends ExpenseTypeState {}
