import 'package:dartz/dartz.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../entity/note_reminder.dart';

abstract class NoteReminderRepository {
  Either<Failure, NoteReminder> getReminder(String noteKey, WriteOn box);
}
