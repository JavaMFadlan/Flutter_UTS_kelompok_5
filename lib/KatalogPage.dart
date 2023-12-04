import 'package:flutter/material.dart';
import 'DBHelper.dart';
import 'Formats/Currency.dart';
import 'HomePage.dart';
import 'AboutPage.dart';
import 'LoginPage.dart';
import 'AddKatalogPage.dart';
import 'DetailPage.dart';

class KatalogPage extends StatelessWidget {
  final String email;
  final DBHelper dbHelper = DBHelper();
  KatalogPage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog'),
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
      body: FutureBuilder<List<Katalog>>(
        future: dbHelper.getKatalog(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data![index].nama),
                    subtitle: Text(CurrencyFormat.convertToIdr(snapshot.data![index].harga, 2)),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DetailPage(id: snapshot.data![index].id, email: email)));
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddKatalogPage(email: email)));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
