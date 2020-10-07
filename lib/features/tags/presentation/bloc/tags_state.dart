part of 'tags_bloc.dart';

abstract class TagsState extends Equatable {
  const TagsState();

  @override
  List<Object> get props => [];
}

class TagsInitial extends TagsState {}

class Loaded extends TagsState {
  final List<String> tags;
  final List<String> noteTags;

  Loaded({@required this.tags, @required this.noteTags});

  @override
  List<Object> get props => [tags, noteTags];
}

class Error extends TagsState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
