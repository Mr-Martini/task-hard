import 'package:task_hard/features/home_app_bar/data/model/home_app_bar_model.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

abstract class HomeAppBarLocalDataSource {
  HomeAppBarModel addNote(List<Note> selectedNotes);
}

class HomeAppBarLocalDataSourceImpl implements HomeAppBarLocalDataSource {
  @override
  HomeAppBarModel addNote(List<Note> selectedNotes) {
    return HomeAppBarModel.fromList(selectedNotes);
  }
}
