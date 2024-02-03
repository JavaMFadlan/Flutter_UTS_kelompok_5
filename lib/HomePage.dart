import 'package:flutter/material.dart';
import 'KatalogPage.dart';
import 'LoginPage.dart';
import 'AboutPage.dart';
import '../bloc/login_bloc.dart';
import 'layout/login.dart';
import 'layout/loading.dart';
import 'layout/dashboard.dart';
import 'layout/error_message.dart';

class HomePage_ extends StatelessWidget {
  final String username;

  HomePage_({this.username = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => HomePage_(username: username)));
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('List'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => KatalogPage(username: username)));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => AboutPage(username: username)));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: Transform.translate(
          offset: Offset(0.0, -40.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Selamat Datang Kembali!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
                SizedBox(
                  height: 30.0,
                  ),
                CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  radius: 60.0,
                ),
                SizedBox(
                  height: 30.0,
                  ),
                Text('username : ' + username, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              ],
            ),
          ),
          ),
    );
  }
}
