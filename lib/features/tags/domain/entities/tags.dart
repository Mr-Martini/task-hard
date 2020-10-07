import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TagsEntity extends Equatable {
  final List<String> tags;
  final List<String> noteTags;

  TagsEntity({@required this.tags, @required this.noteTags});

  @override
  List<Object> get props => [tags, noteTags];
}
