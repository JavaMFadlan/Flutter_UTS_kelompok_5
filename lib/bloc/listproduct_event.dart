part of 'listproduct_bloc.dart';

sealed class ListproductEvent extends Equatable {}

final class LoadListProductEvent extends ListproductEvent {
  final String keyword;

  LoadListProductEvent({this.keyword = ""});

  List<Object?> get props => [];
}
