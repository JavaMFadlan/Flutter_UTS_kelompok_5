import 'package:flutter/material.dart';
import 'package:flutter_uts/bloc/addproduct_bloc.dart';
import 'SplashScreen.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';
import 'HomePage.dart';
import 'KatalogPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            ), // BlocProvider
            BlocProvider(
              create: (context) =>
                  AddProductBloc(productRepository: context.read<ProductRepository>())
            ), // BlocProvider
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "YOOO THRIFTHING",
            home: HomePage()
          ),
        ), // MultiBlocProvider
      ); // MultiRepositoryProvider
    
  }
}


