    import 'package:flutter/material.dart';
    import 'HomePage.dart';
    import 'LoginPage.dart';
    import 'KatalogPage.dart';

   class AboutPage extends StatelessWidget {
  final String email;

  AboutPage({required this.email});

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
            Text('Kelompok 5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36.0)),
          ],
        ),
      ),
    );
  }
}


