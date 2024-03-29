import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import '../bloc/addproduct_bloc.dart';
import '../repository/product_repository.dart';
import 'dart:io';

class AddDataForm extends StatefulWidget {
  const AddDataForm({Key? key}) : super(key: key);

  @override
  _AddDataFormState createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Content'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
              ),
              _pickedImage != null
                  ? Container(
                      height: 300,
                      child: Image.file(
                        _pickedImage!,
                        fit: BoxFit.cover,
                      ))
                  : const SizedBox.shrink(),
              ElevatedButton(
                  onPressed: () async {
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
                  child: Text('Pick Image')),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    if (_pickedImage == null) {
                      titleController.text = "";
                      contentController.text = "";
                      dateController.text = "";
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('No Image'),
                            content: const Text('Lengkapi Field'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      final title = titleController.text;
                      final content = contentController.text;
                      final date = dateController.text;
                      final image = _pickedImage;
                      context.read<AddproductBloc>().add(ClickTombolAddEvent(
                          title: title,
                          content: content,
                          date: date,
                          image: image!));
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Berhasil'),
                            content: const Text('Informasi telah dipost'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text('POST')),
            ],
          ),
        ),
      ),
    );
  }
}
