part of 'editinfo_bloc.dart';

sealed class EditinfoEvent extends Equatable {}

final class SetInit extends EditinfoEvent {
  @override
  List<Object?> get props => [];
}

final class ClickEdit extends EditinfoEvent {
  final String id;
  final String title;
  final String content;
  final String date;
  final File? image;

  ClickEdit(
      {required this.id,
      required this.title,
      required this.content,
      required this.date,
      this.image});

  @override
  List<Object?> get props => [id, title, content, date, image];
}
