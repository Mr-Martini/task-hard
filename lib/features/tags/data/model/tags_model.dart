import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/tags.dart';

class TagsModel extends Equatable implements TagsEntity {
  final List<String> tags;
  final List<String> noteTags;

  TagsModel({@required this.tags, @required this.noteTags});

  @override
  List<Object> get props => [tags, noteTags];

  factory TagsModel.fromIterable(
      Iterable<dynamic> tagsFromDB, dynamic noteMap) {
    List<String> aux = List<String>.from(noteMap['tags'] ?? <String>[]);
    return TagsModel(
      tags: List<String>.from(tagsFromDB ?? <String>[]),
      noteTags: aux,
    );
  }
}
