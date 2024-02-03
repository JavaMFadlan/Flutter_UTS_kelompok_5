import 'package:flutter/material.dart';
import 'Formats/Currency.dart';
import 'KatalogPage.dart';
import 'AboutPage.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'DBHelper.dart';

class DetailPage extends StatelessWidget {
  final int id;
  final String username;
  final DBHelper dbHelper = DBHelper();

  DetailPage({required this.id, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
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
     body: Center(
      child: FutureBuilder<Katalog>(
        future: dbHelper.getKatalogById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Image.asset('assets/images/clothes.jpg', width: 300.0,),
                SizedBox(
                  height: 30.0,
                ),
                Divider(
                  color: Colors.black12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: Text(' ${snapshot.data?.nama ?? 'Default Value'}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36.0)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, bottom: 20.0),
                      child: Text(
                        CurrencyFormat.convertToIdr(snapshot.data?.harga, 2),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, bottom: 50.0),
                      child: Text('Deskripsi : ${snapshot.data?.deskripsi ?? 'Default Value'}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0)),
                      ),
                  ],
                ),
                Divider(
                  color: Colors.black12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Penjual : ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0)),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.brown.shade800,
                              radius: 10.0,
                            ),
                          ),
                          Text(' ${'Default Value'}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0)),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black12,
                ),
              ],
            );
          }
        },
      ),
    ),
    );
  }
}
