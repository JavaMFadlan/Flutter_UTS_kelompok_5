import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uts/KatalogPage.dart';
import 'package:flutter_uts/bloc/listproduct_bloc.dart';

class KatalogInfo extends StatefulWidget {
  const KatalogInfo({super.key});

  @override
  State<KatalogInfo> createState() => _KatalogInfoState();
}

class _KatalogInfoState extends State<KatalogInfo> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListproductBloc, ListproductState>(
      builder: (context, state) {
        if (state is LoadingProduct) {
          return CircularProgressIndicator.adaptive();
        } else if (state is ListproductInitial) {
          return ListInfoView(
            info: state.info,
            searchText: state.searchText,
          );
        } else {
          return Container(
            child: Text("error state"),
          );
        }
      },
    );
  }
}
