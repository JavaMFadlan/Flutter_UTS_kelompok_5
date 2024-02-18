part of 'addproduct_bloc.dart';

sealed class AddproductEvent extends Equatable {
  const AddproductEvent();
  @override
  List<Object> get props => [];
}

final class AddproductInitial extends AddproductEvent {
  const AddproductInitial();
  @override
  List<Object> get props => [];
}

final class ClickTombolAddEvent extends AddproductEvent {
  final String title;
  final String content;
  final String date;
  final File image;

  const ClickTombolAddEvent({
    required this.title,
    required this.content,
    required this.date,
    required this.image,
  });

  @override
  List<Object> get props => [title, content, date, image];
}
