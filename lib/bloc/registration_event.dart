part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegisterUser extends RegistrationEvent {
  final String username;
  final String password;
  final String email;

  RegisterUser({
    required this.username,
    required this.password,
    required this.email,
  });

  @override
  List<Object> get props => [username, password, email];
}
