import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'KatalogPage.dart';
import 'DBHelper.dart';

class AddKatalogPage extends StatelessWidget {
 final String username;
 final TextEditingController namaController = TextEditingController();
 final TextEditingController hargaController = TextEditingController();
 final TextEditingController deskripsiController = TextEditingController();

 final DBHelper dbHelper = DBHelper();

 AddKatalogPage({required this.username});

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Add Katalog Page'),
     ),
     body: Padding(
       padding: const EdgeInsets.all(20.0),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
           SizedBox(
              height: 30.0,
            ),
           ElevatedButton(
             onPressed: () {
               String username = this.username;
               String nama = namaController.text;
               int? harga = int.tryParse(hargaController.text);
               if (harga == null) {
                 print('Invalid harga');
                 return;
               }
               String deskripsi = deskripsiController.text;
               dbHelper.insertKatalog(username, nama, harga, deskripsi);
               Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => KatalogPage(username: username)));
             },
             child: const Text('Submit'),
           ),
         ],
       ),
     ),
   );
 }
}

