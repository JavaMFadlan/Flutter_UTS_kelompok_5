import 'package:flutter/material.dart';
import 'KatalogPage.dart';
import 'LoginPage.dart';
import 'AboutPage.dart';

class HomePage extends StatelessWidget {
  final String email;

  HomePage({required this.email});

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
                    MaterialPageRoute(builder: (_) => HomePage(email: email)));
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('List'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => KatalogPage(email: email)));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => AboutPage(email: email)));
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
                Text('Email : ' + email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              ],
            ),
          ),
          ),
    );
  }
}
