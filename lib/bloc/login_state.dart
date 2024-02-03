part of 'login_bloc.dart';

@immutable
sealed class LoginState{}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String sessionToken;
  final String username;
  LoginSuccess({required this.sessionToken, required this.username});
}

class LoginFailure extends LoginState{
  final String error;
  LoginFailure({required this.error});
}

