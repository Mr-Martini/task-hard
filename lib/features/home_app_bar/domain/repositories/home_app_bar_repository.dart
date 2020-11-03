import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/home_app_bar_entity.dart';

abstract class HomeAppBarRepository {
  Either<Failure, HomeAppBarEntity> addNote(List<Note> notes);
  Either<Failure, HomeAppBarEntity> changeColor(
      Color color, List<Note> notes, WriteOn box);
  Either<Failure, HomeAppBarEntity> deleteNotes(List<Note> notes, WriteOn box);
  Either<Failure, HomeAppBarEntity> undoDelete(List<Note> notes, WriteOn box);
  Either<Failure, HomeAppBarEntity> archiveNotes(List<Note> notes, WriteOn box);
  Either<Failure, HomeAppBarEntity> undoArchive(List<Note> notes, WriteOn box);
  Either<Failure, HomeAppBarEntity> deleteReminder(
      List<Note> notes, WriteOn box);
  Either<Failure, HomeAppBarEntity> putReminder(
    List<Note> notes,
    DateTime scheduledDate,
    String repeat,
    WriteOn box,
  );
}
