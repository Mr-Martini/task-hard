import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NoteTagsEntity extends Equatable {
  final List<String> tags;

  NoteTagsEntity({@required this.tags});

  @override
  List<Object> get props => [tags];
}
