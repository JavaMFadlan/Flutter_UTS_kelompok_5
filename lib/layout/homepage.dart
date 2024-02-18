import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uts/LoginPage.dart';

import '../bloc/login_bloc.dart';

import 'loading.dart';
import '../HomePage.dart';

import 'error_message.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginInitial) {
          return LoginForm();
        } else if (state is LoginLoading) {
          return LoadingIndicator();
        } else if (state is LoginSuccess) {
          return HomePage_(username: state.username);
        } else if (state is LoginFailure) {
          return LoginForm();
        } else {
          return Container();
        }
      },
    );
  }
}
