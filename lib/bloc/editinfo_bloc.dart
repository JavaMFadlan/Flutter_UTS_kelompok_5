import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_uts/repository/product_repository.dart';

part 'editinfo_event.dart';
part 'editinfo_state.dart';

class EditinfoBloc extends Bloc<EditinfoEvent, EditinfoState> {
  final ProductRepository productRepository;
  EditinfoBloc({required this.productRepository}) : super(EditinfoInitial()) {
    on<SetInit>(_setInit);
    on<ClickEdit>(_editinfo);
  }
  _setInit(SetInit event, Emitter emit) {
    emit(EditinfoInitial());
  }

  _editinfo(ClickEdit event, Emitter emit) async {
    try {
      //state 1
      emit(LoadingEdit());
      log('message test ${event.id}');

      bool result = await productRepository.editInfo(
          id: event.id,
          title: event.title,
          content: event.content,
          date: event.date,
          image: event.image ?? null);
      log('message test: $ErrorEdit');
      // jika sukses state 2
      if (result == true) {
        emit(SuccessEdit(message: "Berita ${event.title} Berhasil di ubah"));
      } else {
        emit(ErrorEdit(error: "Error: Gagal Merubah Berita"));
      }
    } catch (error) {
      // state 2 if error
      emit(ErrorEdit(error: 'Error : $error'));
      log(error.toString());
    }
  }
}
