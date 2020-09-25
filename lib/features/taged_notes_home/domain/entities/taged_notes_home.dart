import 'package:equatable/equatable.dart';

class TagedNotesHome extends Equatable {
  final bool should;

  TagedNotesHome(this.should);

  @override
  List<Object> get props => [should];
}
