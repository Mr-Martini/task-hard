import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../note/domain/entities/note.dart';

class HomeAppBarEntity extends Equatable {
  final List<Note> selectedNotes;

  HomeAppBarEntity({@required this.selectedNotes});

  @override
  List<Object> get props => [selectedNotes];
}
