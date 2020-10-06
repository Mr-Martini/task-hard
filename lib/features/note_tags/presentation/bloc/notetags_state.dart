part of 'notetags_bloc.dart';

abstract class NoteTagsState extends Equatable {
  const NoteTagsState();

  @override
  List<Object> get props => [];
}

class NoteTagsInitial extends NoteTagsState {}

class Loaded extends NoteTagsState {
  final List<String> tags;

  Loaded({@required this.tags});

  @override
  List<Object> get props => [tags];
}

class Error extends NoteTagsState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
