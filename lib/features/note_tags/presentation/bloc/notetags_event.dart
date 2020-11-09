part of 'notetags_bloc.dart';

abstract class NoteTagsEvent extends Equatable {
  const NoteTagsEvent();

  @override
  List<Object> get props => [];
}

class GetTags extends NoteTagsEvent {
  final String noteKey;
  final WriteOn box;

  GetTags({
    @required this.noteKey,
    @required this.box,
  });

  @override
  List<Object> get props => [noteKey, box];
}
