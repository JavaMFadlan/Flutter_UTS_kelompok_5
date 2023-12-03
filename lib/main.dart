import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';
import 'HomePage.dart';
import 'KatalogPage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login App',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => SplashScreen());
        } else if (settings.name == '/login') {
          return MaterialPageRoute(builder: (context) => LoginPage());
        } else if (settings.name == '/signup') {
          return MaterialPageRoute(builder: (context) => SignupPage());
        } else if (settings.name == '/home') {
          final args = settings.arguments as String;
          return MaterialPageRoute(builder: (context) => HomePage(email: args));
        } else if (settings.name == '/katalog') {
          final args = settings.arguments as String;
          return MaterialPageRoute(builder: (context) => KatalogPage(email: args));
        }
         else {
          throw Exception('Invalid route');
        }
      },
    );
  }
}


