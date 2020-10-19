import '../../domain/entities/taged_notes_home.dart';

class TagedNotesHomeModel extends TagedNotesHome {
  final bool should;

  TagedNotesHomeModel(this.should) : super(should);

  factory TagedNotesHomeModel.fromBool(bool should) {
    return TagedNotesHomeModel(should);
  }

  bool toBool() {
    return should;
  }
}
