import 'package:flutter/material.dart';
import 'DBHelper.dart';
import 'AddKatalogPage.dart';

class KatalogPage extends StatelessWidget {
  final String email;
  final DBHelper dbHelper = DBHelper();
  KatalogPage({required this.email});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Page'),
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
                    subtitle: Text(snapshot.data![index].harga.toString()),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddKatalogPage(email: email,)));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
