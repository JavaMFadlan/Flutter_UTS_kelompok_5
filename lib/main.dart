import 'package:flutter/material.dart';
import 'package:flutter_uts/bloc/addproduct_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uts/bloc/detail_bloc.dart';
import 'package:flutter_uts/bloc/editinfo_bloc.dart';
import 'package:flutter_uts/bloc/listproduct_bloc.dart';
import 'package:flutter_uts/bloc/registration_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_uts/repository/login_repository.dart';
import 'package:flutter_uts/repository/product_repository.dart';
import 'layout/homepage.dart';
import '../bloc/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LoginRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProductRepository(),
        ), // RepositoryProvider
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                LoginBloc(loginRepository: context.read<LoginRepository>())
                  ..add(const InitLogin()),
          ),
          BlocProvider(
              create: (context) => RegistrationBloc(
                  repository: context.read<LoginRepository>())), // BlocProvider
          BlocProvider(
              create: (context) => AddproductBloc(
                  productRepository: context.read<ProductRepository>())),
          BlocProvider(
              create: (context) => ListproductBloc(
                  productRepository: context.read<ProductRepository>())
                ..add(LoadListProductEvent())),
          BlocProvider(
            create: (context) => DetailBloc(
                productRepository: context.read<ProductRepository>()),
          ),
          BlocProvider(
              create: (context) => EditinfoBloc(
                  productRepository: context.read<ProductRepository>())),
          // BlocProvider
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "YOOO THRIFTHING",
            home: HomePage()),
      ), // MultiBlocProvider
    ); // MultiRepositoryProvider
  }
}
