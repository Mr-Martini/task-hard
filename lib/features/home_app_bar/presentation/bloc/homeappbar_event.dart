part of 'homeappbar_bloc.dart';

abstract class HomeappbarEvent extends Equatable {
  const HomeappbarEvent();

  @override
  List<Object> get props => [];
}

class AddNote extends HomeappbarEvent {
  final List<Note> selectedNotes;

  AddNote({@required this.selectedNotes});

  @override
  List<Object> get props => [selectedNotes];
}
