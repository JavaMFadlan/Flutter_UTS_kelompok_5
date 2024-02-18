import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_uts/repository/login_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final LoginRepository repository;

  RegistrationBloc({required this.repository}) : super(RegistrationInitial()) {
    on<RegisterUser>(_onRegisterUser);
  }

  void _onRegisterUser(
      RegisterUser event, Emitter<RegistrationState> emit) async {
    try {
      emit(RegistrationLoading());

      final response = await repository.register(
          username: event.username,
          password: event.password,
          email: event.email);

      emit(RegistrationSuccess(response));
    } catch (error) {
      emit(RegistrationFailure(error.toString()));
    }
  }
}
