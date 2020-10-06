import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/note_tags.dart';

class NoteTagsModel extends Equatable implements NoteTagsEntity {
  final List<String> tags;

  NoteTagsModel({@required this.tags});

  @override
  List<Object> get props => [tags];

  factory NoteTagsModel.fromMap(dynamic note) {
    if (note != null) {
      List<dynamic> tags = note['tags'] ?? [];
      return NoteTagsModel(tags: List<String>.from(tags));
    }
    return NoteTagsModel(tags: <String>[]);
  }
}
