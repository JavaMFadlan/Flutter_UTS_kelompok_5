part of 'detail_bloc.dart';

@immutable
sealed class DetailState extends Equatable {}

final class DetailInitial extends DetailState {
  @override
  List<Object> get props => [];
}

final class DetailLoaded extends DetailState {
  final Map info;

  DetailLoaded({required this.info});

  @override
  List<Object?> get props => [info];
}

final class LoadFailed extends DetailState {
  final String msg;

  LoadFailed({this.msg = "Failed to Load Info"});
  @override
  List<Object?> get props => [msg];
}

final class InfoDeleted extends DetailState {
  final String title;

  InfoDeleted({required this.title});
  @override
  List<Object?> get props => [title];
}
