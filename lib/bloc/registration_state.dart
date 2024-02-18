part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationLoading extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationSuccess extends RegistrationState {
  final dynamic response;

  RegistrationSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure(this.error);

  @override
  List<Object> get props => [error];
}
