import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_uts/repository/product_repository.dart';

part 'listproduct_event.dart';
part 'listproduct_state.dart';

class ListproductBloc extends Bloc<ListproductEvent, ListproductState> {
  ProductRepository productRepository;
  ListproductBloc({required this.productRepository}) : super(LoadingProduct()) {
    on<LoadListProductEvent>((_listinfo));
  }
  _listinfo(event, Emitter emit) async {
    String key = event.keyword;

    emit(LoadingProduct());
    List res = await productRepository.getProductList(key);
    emit(ListproductInitial(info: res, searchText: key));
  }
}
