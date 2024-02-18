import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_uts/repository/product_repository.dart';
import 'package:meta/meta.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  ProductRepository productRepository;
  DetailBloc({required this.productRepository}) : super(DetailInitial()) {
    on<LoadInfoEvent>(_loadInfo);
    on<DeleteInfo>(_deleteinfo);
  }

  _loadInfo(LoadInfoEvent event, Emitter emit) async {
    String infoId = event.infoId;
    emit(DetailInitial());
    Map res = await productRepository.selectInfo(infoId);
    if (res['status'] == true) {
      emit(DetailLoaded(info: res));
    } else {
      emit(LoadFailed(msg: res['msg']));
    }
  }

  _deleteinfo(DeleteInfo event, Emitter emit) async {
    String idk = event.id;
    String title = event.title;
    emit(DetailInitial());
    bool res = await productRepository.deleteProduct(idk);
    log("000 $res");
    if (res == true) {
      emit(InfoDeleted(title: title));
    } else {
      Map res = await productRepository.selectInfo(idk);
      log("RESLOAD $res");
      if (res['status'] == true) {
        emit(DetailLoaded(info: res));
      } else {
        emit(LoadFailed(msg: res['msg']));
      }
    }
  }
}
