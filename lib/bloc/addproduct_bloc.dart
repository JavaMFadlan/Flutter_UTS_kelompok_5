import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_uts/repository/product_repository.dart';

part 'addproduct_event.dart';
part 'addproduct_state.dart';

class AddProductBloc extends Bloc<AddproductEvent, AddproductState> {
  final ProductRepository productRepository;

  AddProductBloc({required this.productRepository}) : super(AddProductInitialState());

  @override
  Stream<AddproductState> mapEventToState(AddproductEvent event) async* {
    if (event is AddproductInitial) { // Corrected typo here
      yield* _mapAddProductInitialToState(event);
    }
  }

  Stream<AddproductState> _mapAddProductInitialToState(AddproductInitial event) async* { // Corrected typo here
    try {
      yield AddProductLoadingState(); // state 1
      final result = await productRepository.addProduct(
        title: event.title,
        desc: event.desc,
        date: event.date,
        image: event.image,
      );
      yield AddProductSuccessState(message: result); // state 2 if success
      await Future.delayed(Duration(seconds: 3));
      yield AddProductInitialState(); // state 3 after delay
    } catch (error) {
      yield AddProductErrorState(error: 'Error: $error'); // state 3 if error
    }
  }
}
