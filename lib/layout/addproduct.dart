import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/addproduct_bloc.dart';
import 'adddataform.dart';

class ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddproductBloc, AddproductState>(
      builder: (context, state) {
        if (state is AddProductInitialState) {
          return AddDataForm();
        } else if (state is AddProductLoadingState) {
          return CircularProgressIndicator();
        } else if (state is AddProductSuccessState) {
          return Text(state.message);
        } else if (state is AddProductErrorState) {
          return Text('Error: ${state.error}');
        } else {
          return Container();
        }
      },
    );
  }
}
