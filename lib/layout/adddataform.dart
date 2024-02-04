import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import '../bloc/addproduct_bloc.dart';



class AddDataForm extends StatefulWidget {
  const AddDataForm({super.key});

  @override
  State<AddDataForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _date = TextEditingController();
  File? _pickedImage;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Data'),),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _title,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _desc,
                decoration: InputDecoration(labelText: 'Content'),
              ),
              TextField(
                controller: _date,
                decoration: InputDecoration(labelText: 'Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      _date.text = formattedDate;
                    });
                  }
                },
              ),
              _pickedImage != null
                    ? Container(
                        height: 300,
                        child: Image.file(
                          _pickedImage!,
                          fit: BoxFit.cover,
                        ),
                      ) // Image.file // Container
                    : SizedBox.shrink(),
                ElevatedButton(
                  onPressed: () async {
                    // Fungsi pemilihan file dari perangkat lokal dan fil
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg'],
                    );
                    if (result != null && result.files.isNotEmpty) {
                      setState(() {
                        _pickedImage = File(result.files.single.path!);
                      });
                    }
                  },
                  child: Text('Pick Image (.jpg)'),
                ),
                SizedBox(height: 16),
                  ElevatedButton(
                onPressed: () {
                  if (_pickedImage == null ||
                      _title.text.isEmpty ||
                      _desc.text.isEmpty ||
                      _date.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('No Image'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Silahkan Lengkapi Data'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    final title = _title.text;
                    final desc = _desc.text;
                    final date = _date.text;
                    final image = _pickedImage;
                    context.read<AddProductBloc>().add(
                          AddproductInitial(
                            title: title,
                            desc: desc,
                            date: date,
                            image: image!,
                          ),
                        );
                  }
                },
                child: Text("Add News"),
              ),

                  ],
                ),
            ),
            )
    );
  }
}