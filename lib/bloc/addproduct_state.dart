part of 'addproduct_bloc.dart';

sealed class AddproductState extends Equatable {}

class AddProductInitialState extends AddproductState {
  @override
  List<Object> get props => [];
}

class AddProductLoadingState extends AddproductState {
  @override
  List<Object> get props => [];
}

class AddProductSuccessState extends AddproductState {
  final String message;

  AddProductSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class AddProductErrorState extends AddproductState {
  final String error;

  AddProductErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
