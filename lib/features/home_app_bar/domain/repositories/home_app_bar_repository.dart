import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/features/home_app_bar/domain/entities/home_app_bar_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../note/domain/entities/note.dart';

abstract class HomeAppBarRepository {
  Either<Failure, HomeAppBarEntity> addNote(List<Note> notes);
  Either<Failure, HomeAppBarEntity> changeColor(Color color, List<Note> notes);
  Either<Failure, HomeAppBarEntity> deleteNotes(List<Note> notes);
}
