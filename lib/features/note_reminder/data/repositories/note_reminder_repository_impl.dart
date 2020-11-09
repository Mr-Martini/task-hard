import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entity/note_reminder.dart';
import '../../domain/repositories/note_reminder_repository.dart';
import '../datasources/note_reminder_local_data_source.dart';

class NoteReminderRepositoryImpl implements NoteReminderRepository {
  final NoteReminderLocalDataSource dataSource;

  NoteReminderRepositoryImpl({@required this.dataSource});

  @override
  Either<Failure, NoteReminder> getReminder(String noteKey, WriteOn box) {
    try {
      final note = dataSource.getReminder(noteKey, box);
      return Right(note);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
