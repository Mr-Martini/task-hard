import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../entities/note.dart';

abstract class NoteRepository {
  Either<Failure, Note> getNoteByKey(String key);
  Either<Failure, Note> writeNoteContent(String content, String key);
  Either<Failure, Note> writeNoteTitle(String title, String key);
  Either<Failure, Note> writeNoteColor(Color color, String key);
  Either<Failure, Note> writeNoteReminder(
    DateTime reminder,
    TimeOfDay time,
    String repeat,
    String key,
    String title,
    String message,
  );
  Either<Failure, Note> deleteNoteReminder(String key);
  Either<Failure, Note> deleteNote(String key);
  Either<Failure, Note> archiveNote(String key);
  Either<Failure, Note> copyNote(
    String key,
    String title,
    String content,
    Color color,
  );
}
