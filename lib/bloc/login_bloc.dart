import 'package:bloc/bloc.dart';
import 'package:flutter_uts/repository/login_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) :super(LoginInitial()){
    on<InitLogin>(_initLogin);
    on<ProsesLogout>(_prosesLogout);
    on<ProsesLogin>(_prosesLogin);
  }
  

  _initLogin(InitLogin event, Emitter emit) async{
    emit(LoginLoading());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('session') ?? "";
    final String userName = prefs.getString('user') ?? "";

    if (sessionToken == "") {
      emit(LoginInitial());
    } else {
      bool result = await loginRepository.checkSession(sessionToken);

      if (result) {
        emit(LoginSuccess(sessionToken: sessionToken, username: userName));
      } else {
        emit(LoginInitial());
      }
    }
  }
  _prosesLogout(ProsesLogout event, Emitter emit) async{
    emit(LoginLoading());
    await loginRepository.logout();
    emit(LoginInitial());
  }
  _prosesLogin(ProsesLogin event, Emitter emit) async{
    String username = event.username;
    String password = event.password;

    emit(LoginLoading());

    Map res = await loginRepository.login(username: username, password: password);

    if (res['status'] == true) {
      emit(LoginSuccess(sessionToken: res['data']['session_token'], username: res['data']['username']));
    } else {
      emit(LoginFailure(error: 'Login failed: ${res['data']['message']}'));
    }
  }
}