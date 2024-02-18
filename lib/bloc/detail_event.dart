part of 'detail_bloc.dart';

@immutable
sealed class DetailEvent extends Equatable {}

class LoadInfoEvent extends DetailEvent {
  final String infoId;

  LoadInfoEvent({required this.infoId});
  @override
  List<Object?> get props => [infoId];
}

final class DeleteInfo extends DetailEvent {
  final String id;
  final String title;

  DeleteInfo({required this.id, required this.title});
  @override
  List<Object?> get props => [id, title];
}
