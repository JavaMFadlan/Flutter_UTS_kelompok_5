import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/editinfo_bloc.dart';

class EditForm extends StatefulWidget {
  final String id, title, url, desc, date;
  const EditForm(
      {required this.id,
      required this.title,
      this.url = '',
      required this.desc,
      required this.date});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  File? _pickedImage;
  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    contentController.text = widget.desc;
    dateController.text = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Data'),
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
              _pickedImage == null
                  ? Image.network(
                      widget.url,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    )
                  : const SizedBox.shrink(),
              _pickedImage != null
                  ? SizedBox(
                      width: double.infinity,
                      child: Image.file(
                        _pickedImage!,
                        fit: BoxFit.contain,
                      ),
                    )
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
                    if ((_pickedImage == null && widget.url == "") ||
                        titleController.text == "" ||
                        contentController.text == "" ||
                        dateController.text == "") {
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
                      final id = widget.id;
                      final title = titleController.text;
                      final content = contentController.text;
                      final date = dateController.text;
                      final image = _pickedImage;

                      context.read<EditinfoBloc>().add(ClickEdit(
                          id: id,
                          title: title,
                          content: content,
                          date: date,
                          image: image));

                      log(id);
                      log(title);
                      log(content);
                      log(date);
                      log('$image');
                      debugPrint("Image URL: ${widget.url}");
                    }
                  },
                  child: Text('Edit Info')),
            ],
          ),
        ),
      ),
    );
  }
}
