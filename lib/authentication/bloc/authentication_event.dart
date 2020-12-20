part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.authUser);

  final AuthUser authUser;

  @override
  List<Object> get props => [authUser];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
