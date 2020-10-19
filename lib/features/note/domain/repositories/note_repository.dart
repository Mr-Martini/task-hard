import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../entities/note.dart';

abstract class NoteRepository {
  Either<Failure, Note> getNoteByKey(String key, WriteOn box);
  Either<Failure, Note> writeNoteContent(String content, String key, WriteOn box);
  Either<Failure, Note> writeNoteTitle(String title, String key, WriteOn box);
  Either<Failure, Note> writeNoteColor(Color color, String key, WriteOn box);
  Either<Failure, Note> writeNoteReminder(
    DateTime reminder,
    TimeOfDay time,
    String repeat,
    String key,
    String title,
    String message,
    WriteOn box,
  );
  Either<Failure, Note> deleteNoteReminder(String key, WriteOn box);
  Either<Failure, Note> deleteNote(String key, WriteOn box);
  Either<Failure, Note> archiveNote(String key, WriteOn box);
  Either<Failure, Note> copyNote(
    String key,
    String title,
    String content,
    Color color,
    WriteOn box,
  );
}
