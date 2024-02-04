import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import 'adddatastate.dart';



class Dashboard extends StatefulWidget {
  final String name;
  const Dashboard({required this.name});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Apps')),
      body: Column(
        children: <Widget>[
          Text("Selamat Datang" + widget.name + "di sini"),
          ElevatedButton(onPressed: (){
            context.read<LoginBloc>().add(ProsesLogout());
          }, child: Text("logout")),
          ElevatedButton(onPressed: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddState()));
          }, child: Text("Tambah Data")),

          
      ],
      ),
    );
  }
}

