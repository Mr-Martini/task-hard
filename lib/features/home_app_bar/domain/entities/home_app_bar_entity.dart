import 'package:equatable/equatable.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:meta/meta.dart';

class HomeAppBarEntity extends Equatable {
  final List<Note> selectedNotes;

  HomeAppBarEntity({@required this.selectedNotes});

  @override
  List<Object> get props => [selectedNotes];
}
