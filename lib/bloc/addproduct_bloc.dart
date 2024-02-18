import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_uts/repository/product_repository.dart';

part 'addproduct_event.dart';
part 'addproduct_state.dart';

class AddproductBloc extends Bloc<AddproductEvent, AddproductState> {
  final ProductRepository productRepository;
  AddproductBloc({required this.productRepository})
      : super(AddProductInitialState()) {
    on<AddproductInitial>(_addproductinitial);
    on<ClickTombolAddEvent>(_addproductclick);
  }

  _addproductinitial(AddproductInitial event, Emitter emit) async {
    emit(AddProductLoadingState());
    emit(AddProductInitialState());
  }

  _addproductclick(ClickTombolAddEvent event, Emitter emit) async {
    final String judul = event.title;
    final String deskripsi = event.content;
    final String tanggal = event.date;
    final File gambar = event.image;
    emit(AddProductLoadingState());

    try {
      final result = await productRepository.addProduct(
          title: judul, desc: deskripsi, date: tanggal, image: gambar);

      emit(AddProductSuccessState(message: result));
      await Future.delayed(Duration(seconds: 3));
      emit(AddProductLoadingState());
    } catch (error) {
      emit(AddProductErrorState(error: "Error $error"));
    }
  }
}
