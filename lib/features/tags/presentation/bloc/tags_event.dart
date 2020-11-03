part of 'tags_bloc.dart';

abstract class TagsEvent extends Equatable {
  const TagsEvent();

  @override
  List<Object> get props => [];
}

class GetTags extends TagsEvent {
  final String noteKey;
  final WriteOn box;

  GetTags({@required this.noteKey, @required this.box});

  @override
  List<Object> get props => [noteKey, box];
}

class GetTagForList extends TagsEvent {
  final List<Note> notes;
  final WriteOn box;

  GetTagForList({@required this.notes, @required this.box});

  @override
  List<Object> get props => [notes, box];
}

class GetOnlyTags extends TagsEvent {}

class AddTagOnNote extends TagsEvent {
  final String tagName;
  final String noteKey;
  final WriteOn box;

  AddTagOnNote(
      {@required this.tagName, @required this.noteKey, @required this.box});

  @override
  List<Object> get props => [noteKey, tagName, box];
}

class AddTagOnList extends TagsEvent {
  final String tagName;
  final List<Note> notes;
  final WriteOn box;

  AddTagOnList({
    @required this.tagName,
    @required this.notes,
    @required this.box,
  });

  @override
  List<Object> get props => [notes, tagName, box];
}

class RemoveTagFromNote extends TagsEvent {
  final String tagName;
  final String noteKey;
  final WriteOn box;

  RemoveTagFromNote({
    @required this.tagName,
    @required this.noteKey,
    @required this.box,
  });

  @override
  List<Object> get props => [noteKey, tagName, box];
}

class RemoveTagFromList extends TagsEvent {
  final String tagName;
  final List<Note> notes;
  final WriteOn box;

  RemoveTagFromList({
    @required this.tagName,
    @required this.notes,
    @required this.box,
  });

  @override
  List<Object> get props => [notes, tagName, box];
}
