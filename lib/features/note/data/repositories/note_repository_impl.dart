import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_data_source.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource dataSource;

  NoteRepositoryImpl({@required this.dataSource});

  @override
  Either<Failure, Note> getNoteByKey(String key) {
    try {
      final note = dataSource.getNoteByKey(key);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> writeNoteContent(String content, String key) {
    try {
      final note = dataSource.writeNoteContent(content, key);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> writeNoteTitle(String title, String key) {
    try {
      final note = dataSource.writeNoteTitle(title, key);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> writeNoteColor(Color color, String key) {
    try {
      final note = dataSource.writeNoteColor(color, key);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> writeNoteReminder(DateTime reminder, TimeOfDay time,
      String repeat, String key, String title, String message) {
    try {
      final note = dataSource.writeNoteReminder(
        reminder,
        time,
        repeat,
        key,
        title,
        message,
      );
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> deleteNoteReminder(String key) {
    try {
      final note = dataSource.deleteNoteReminder(key);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> deleteNote(String key) {
    try {
      final note = dataSource.deleteNote(key);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> archiveNote(String key) {
    try {
      final note = dataSource.archiveNote(key);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Note> copyNote(
      String key, String title, String content, Color color) {
    try {
      final note = dataSource.copyNote(key, title, content, color);
      return Right(note);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }
}
