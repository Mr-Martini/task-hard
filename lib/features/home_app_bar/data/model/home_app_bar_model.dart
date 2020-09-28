import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../note/domain/entities/note.dart';
import '../../domain/entities/home_app_bar_entity.dart';

class HomeAppBarModel extends Equatable implements HomeAppBarEntity {
  final List<Note> selectedNotes;

  HomeAppBarModel({@required this.selectedNotes});

  @override
  List<Object> get props => [selectedNotes];

  factory HomeAppBarModel.fromList(List<Note> notes) {
    return HomeAppBarModel(selectedNotes: notes);
  }

  List<Note> toList() {
    return selectedNotes;
  }
}
