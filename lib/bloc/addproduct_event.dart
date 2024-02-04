part of 'addproduct_bloc.dart';

sealed class AddproductEvent extends Equatable {}

final class AddproductInitial extends AddproductEvent{
  final String title;
  final String desc;
  final String date;
  final File image;

  AddproductInitial({
    required this.title,
    required this.desc,
    required this.date,
    required this.image
  });
  @override
  List<Object> get props => [title, desc, date, image];

}