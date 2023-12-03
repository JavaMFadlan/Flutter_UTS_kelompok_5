import 'package:flutter/material.dart';
import 'package:flutter_uts/LoginPage.dart';
import 'DBHelper.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Page'),
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
          ElevatedButton(
            onPressed: () async {
              String email = emailController.text;
              String password = passwordController.text;
              await dbHelper.insertUser(email, password);
              Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => LoginPage()));
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
