import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uts/bloc/login_bloc.dart';
import 'package:flutter_uts/layout/katalogpagestate.dart';
import 'HomePage.dart';

class AboutPage extends StatelessWidget {
  final String username;

  AboutPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => HomePage_(username: username)));
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('List'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KatalogInfo()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AboutPage(username: username)));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                context.read<LoginBloc>().add(const ProsesLogout());
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 60.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text('Kelompok 5',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36.0)),
          ],
        ),
      ),
    );
  }
}
