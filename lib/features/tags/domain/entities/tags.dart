import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../note/domain/entities/note.dart';

class TagsEntity extends Equatable {
  final List<String> tags;
  final List<String> noteTags;
  final List<Note> noteList;

  TagsEntity({
    @required this.tags,
    @required this.noteTags,
    @required this.noteList,
  });

  @override
  List<Object> get props => [tags, noteTags, noteList];
}
