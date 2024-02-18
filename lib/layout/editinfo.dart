import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uts/layout/homepage.dart';
import '../bloc/editinfo_bloc.dart';
import 'package:flutter_uts/editform.dart';
import 'package:flutter_uts/layout/error_message.dart';
import 'package:flutter_uts/layout/loading.dart';

class EditInfo extends StatefulWidget {
  final String id, title, url, desc, date;
  EditInfo(
      {required this.id,
      required this.title,
      required this.url,
      required this.desc,
      required this.date});

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<EditinfoBloc>().add(SetInit());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditinfoBloc, EditinfoState>(
      builder: (context, state) {
        if (state is EditinfoInitial) {
          return EditForm(
              id: widget.id,
              title: widget.title,
              url: widget.url,
              desc: widget.desc,
              date: widget.date);
        } else if (state is LoadingEdit) {
          return LoadingIndicator();
        } else if (state is SuccessEdit) {
          return HomePage();
          // Scaffold(
          //   appBar: AppBar(title: const Text("Edit News")),
          //   body: SingleChildScrollView(
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         children: [
          //           Center(
          //             child: Text(
          //               state.message,
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //           Center(
          //             child: ElevatedButton(
          //               onPressed: () {
          //                 Navigator.of(context).pop('reload');
          //               },
          //               child: const Text('Lihat Berita'),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
        } else if (state is ErrorEdit) {
          return ErrorMessage(message: "Gagal Edit");
        } else {
          return Container();
        }
      },
    );
  }
}
