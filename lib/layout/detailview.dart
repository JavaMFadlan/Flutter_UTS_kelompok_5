import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uts/bloc/detail_bloc.dart';
import 'package:flutter_uts/DetailPage.dart';
import 'package:flutter_uts/layout/error_message.dart';
import 'package:flutter_uts/layout/loading.dart';

class DetailInfo extends StatefulWidget {
  final String infoId;
  const DetailInfo({required this.infoId});

  @override
  State<DetailInfo> createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<DetailBloc>().add(LoadInfoEvent(infoId: widget.infoId));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is DetailInitial) {
          return LoadingIndicator();
        } else if (state is LoadFailed) {
          return ErrorMessage(message: state.msg);
        } else if (state is InfoDeleted) {
          return Scaffold(
            appBar: (AppBar(
              title: const Text("Hapus sukses"),
            )),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                        child:
                            Text("berita '${state.title}' Berhasil dihapus")),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop('reload');
                          },
                          child: const Text('Kembali ke List Berita')),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is DetailLoaded) {
          return DetailViewLoad(
              infoId: state.info['id'].toString(),
              title: state.info['title'],
              url: state.info['img'],
              desc: state.info['desc'],
              date: state.info['date']);
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text("unknown error"))),
          );
        }
      },
    );
  }
}
