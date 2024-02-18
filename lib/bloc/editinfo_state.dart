part of 'editinfo_bloc.dart';

sealed class EditinfoState extends Equatable {}

final class EditinfoInitial extends EditinfoState {
  @override
  List<Object?> get props => [];
}

final class LoadingEdit extends EditinfoState {
  @override
  List<Object?> get props => [];
}

final class SuccessEdit extends EditinfoState {
  final String message;
  SuccessEdit({required this.message});
  @override
  List<Object?> get props => [message];
}

final class ErrorEdit extends EditinfoState {
  final String error;
  ErrorEdit({required this.error});
  @override
  List<Object?> get props => [error];
}
