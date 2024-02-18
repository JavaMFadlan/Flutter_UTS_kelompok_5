import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uts/layout/editinfo.dart';
import '../bloc/detail_bloc.dart';

class DetailViewLoad extends StatefulWidget {
  final String infoId, title, url, desc, date;
  DetailViewLoad(
      {required this.infoId,
      required this.title,
      required this.url,
      required this.desc,
      required this.date});

  @override
  State<DetailViewLoad> createState() => _DetailViewLoadState();
}

class _DetailViewLoadState extends State<DetailViewLoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showOptionsDialog(context).then((value) {
                log("RES $value");
                if (value == 'delete') {
                  log("test");
                  context
                      .read<DetailBloc>()
                      .add(DeleteInfo(id: widget.infoId, title: widget.title));
                } else if (value == 'edit') {
                  log("$widget");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditInfo(
                            id: widget.infoId,
                            title: widget.title,
                            url: widget.url,
                            desc: widget.desc,
                            date: widget.date)),
                  ).then((value) {
                    if (value == 'reload') {
                      context
                          .read<DetailBloc>()
                          .add(LoadInfoEvent(infoId: widget.infoId));
                    }
                  });
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                widget.url,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(widget.title,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              Text(widget.desc, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text('Rp.' + widget.date,
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }

  Future showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('kelola data'),
            content: const Text('apa yang anda ingin lakukan'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop('edit');
                },
                child: Text('edit'),
              ),
              TextButton(
                onPressed: () {
                  log("Dialog - Delete pressed");
                  Navigator.of(context).pop('delete');
                },
                child: Text('delete'),
              ),
            ],
          );
        });
  }
}
