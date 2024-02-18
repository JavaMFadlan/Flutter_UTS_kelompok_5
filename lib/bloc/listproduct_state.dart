part of 'listproduct_bloc.dart';

sealed class ListproductState extends Equatable {}

final class ListproductInitial extends ListproductState {
  final List info;
  final String searchText;

  ListproductInitial({required this.info, this.searchText = ""});

  @override
  List<Object> get props => [info, searchText];
}

final class LoadingProduct extends ListproductState {
  @override
  List<Object> get props => [];
}
