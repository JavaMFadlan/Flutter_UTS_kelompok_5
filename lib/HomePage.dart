import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uts/layout/katalogpagestate.dart';
import 'KatalogPage.dart';

import 'AboutPage.dart';
import '../bloc/login_bloc.dart';

import 'layout/adddataform.dart';

class HomePage_ extends StatefulWidget {
  final String username;

  HomePage_({this.username = ''});

  @override
  _HomePage_State createState() => _HomePage_State();
}

class _HomePage_State extends State<HomePage_> {
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        HomePage_(username: widget.username)));
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
                    builder: (context) =>
                        AboutPage(username: widget.username)));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                context.read<LoginBloc>().add(ProsesLogout());
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Tambah Data'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddDataForm()));
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
              Text('Selamat Datang Kembali!',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
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
              Text('username : ' + widget.username,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            ],
          ),
        ),
      ),
    );
  }
}
