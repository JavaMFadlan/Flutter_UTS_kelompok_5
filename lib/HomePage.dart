    import 'package:flutter/material.dart';
    import 'KatalogPage.dart';

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
              child: Text('foto'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('Profile'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('List'),
              onTap: () {
                Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => KatalogPage(email: email)));
              },
            ),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('About'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(email),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Go back!"),
            ),
          ],
        ),
      ),
    );
  }
}


