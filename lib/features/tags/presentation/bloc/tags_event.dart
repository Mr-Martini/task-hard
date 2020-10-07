part of 'tags_bloc.dart';

abstract class TagsEvent extends Equatable {
  const TagsEvent();

  @override
  List<Object> get props => [];
}

class GetTags extends TagsEvent {
  final String noteKey;

  GetTags({@required this.noteKey});

  @override
  List<Object> get props => [noteKey];
}

class GetOnlyTags extends TagsEvent {}

class AddTagOnNote extends TagsEvent {
  final String tagName;
  final String noteKey;

  AddTagOnNote({@required this.tagName, @required this.noteKey});

  @override
  List<Object> get props => [noteKey, tagName];
}

class RemoveTagFromNote extends TagsEvent {
  final String tagName;
  final String noteKey;

  RemoveTagFromNote({@required this.tagName, @required this.noteKey});

  @override
  List<Object> get props => [noteKey, tagName];
}
