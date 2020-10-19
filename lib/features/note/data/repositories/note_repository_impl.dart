import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_data_source.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource dataSource;

  NoteRepositoryImpl({@required this.dataSource});

  @override
  Either<Failure, Note> getNoteByKey(String key, WriteOn box) {
    try {
      final note = dataSource.getNoteByKey(key, box);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> writeNoteContent(String content, String key, WriteOn box) {
    try {
      final note = dataSource.writeNoteContent(content, key, box);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> writeNoteTitle(String title, String key, WriteOn box) {
    try {
      final note = dataSource.writeNoteTitle(title, key, box);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> writeNoteColor(Color color, String key, WriteOn box) {
    try {
      final note = dataSource.writeNoteColor(color, key, box);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> writeNoteReminder(DateTime reminder, TimeOfDay time,
      String repeat, String key, String title, String message, WriteOn box) {
    try {
      final note = dataSource.writeNoteReminder(
        reminder,
        time,
        repeat,
        key,
        title,
        message,
        box,
      );
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> deleteNoteReminder(String key, WriteOn box) {
    try {
      final note = dataSource.deleteNoteReminder(key, box);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> deleteNote(String key, WriteOn box) {
    try {
      final note = dataSource.deleteNote(key, box);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> archiveNote(String key, WriteOn box) {
    try {
      final note = dataSource.archiveNote(key, box);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> copyNote(
      String key, String title, String content, Color color, WriteOn box) {
    try {
      final note = dataSource.copyNote(key, title, content, color, box);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }
}
