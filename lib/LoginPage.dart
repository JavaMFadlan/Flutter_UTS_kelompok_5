import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SignUpPage.dart';
import 'DBHelper.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final DBHelper dbHelper = DBHelper();

  Future<User?> getLogin(String email, String password) async {
    return await dbHelper.getLogin(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;
                  User? user = await getLogin(email, password);
                  if (user != null) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => HomePage(email: email)));
                  } else {
                    print("Login failed");
                  }
                },
                child: const Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SignupPage()));
                },
                child: const Text('Register'),
              ),
            ],
          )
          
        ],
      ),
    );
  }
}
