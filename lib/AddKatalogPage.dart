import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'KatalogPage.dart';
import 'DBHelper.dart';

class AddKatalogPage extends StatelessWidget {
 final String email;
 final TextEditingController namaController = TextEditingController();
 final TextEditingController hargaController = TextEditingController();
 final TextEditingController deskripsiController = TextEditingController();

 final DBHelper dbHelper = DBHelper();

 AddKatalogPage({required this.email});

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Add Katalog Page'),
     ),
     body: Column(
       children: [
         TextFormField(
           controller: namaController,
           decoration: const InputDecoration(
             labelText: 'Nama',
           ),
         ),
         TextFormField(
           controller: hargaController,
           decoration: const InputDecoration(
             labelText: 'Harga',
           ),
           keyboardType: TextInputType.number,
           inputFormatters: <TextInputFormatter>[
             FilteringTextInputFormatter.digitsOnly
           ],
         ),
         TextFormField(
           controller: deskripsiController,
           decoration: const InputDecoration(
             labelText: 'Deskripsi',
           ),
         ),
         ElevatedButton(
           onPressed: () {
             String email = this.email;
             String nama = namaController.text;
             int? harga = int.tryParse(hargaController.text);
             if (harga == null) {
               // Handle the error when harga is not a valid integer
               print('Invalid harga');
               return;
             }
             String deskripsi = deskripsiController.text;
             dbHelper.insertKatalog(email, nama, harga, deskripsi);
             Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => KatalogPage(email: email)));
           },
           child: const Text('Submit'),
         ),
       ],
     ),
   );
 }
}

