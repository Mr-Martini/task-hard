part of 'notetags_bloc.dart';

abstract class NoteTagsEvent extends Equatable {
  const NoteTagsEvent();

  @override
  List<Object> get props => [];
}

class GetTags extends NoteTagsEvent {
  final String noteKey;

  GetTags({@required this.noteKey});

  @override
  List<Object> get props => [noteKey];
}
