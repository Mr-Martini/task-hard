import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../note/domain/entities/note.dart';
import '../../domain/entities/home_app_bar_entity.dart';
import '../../domain/repositories/home_app_bar_repository.dart';
import '../datasources/home_app_local_data_source.dart';

class HomeAppBarRepositoryImpl implements HomeAppBarRepository {
  final HomeAppBarLocalDataSource dataSource;

  HomeAppBarRepositoryImpl({@required this.dataSource});

  @override
  Either<Failure, HomeAppBarEntity> addNote(List<Note> notes) {
    try {
      final list = dataSource.addNote(notes);
      return Right(list);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, HomeAppBarEntity> changeColor(Color color, List<Note> notes) {
    try {
      final list = dataSource.changeColor(notes, color);
      return Right(list);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, HomeAppBarEntity> deleteNotes(List<Note> notes) {
    try {
      final list = dataSource.deleteNotes(notes);
      return Right(list);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, HomeAppBarEntity> undoDelete(List<Note> notes) {
    try {
      final list = dataSource.undoDeleteNotes(notes);
      return Right(list);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, HomeAppBarEntity> archiveNotes(List<Note> notes) {
    try {
      final list = dataSource.archiveNotes(notes);
      return Right(list);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, HomeAppBarEntity> undoArchive(List<Note> notes) {
    try {
      final list = dataSource.undoArchiveNotes(notes);
      return Right(list);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, HomeAppBarEntity> putReminder(
      List<Note> notes, DateTime scheduledDate, String repeat) {
    try {
      final list = dataSource.putReminder(notes, scheduledDate, repeat);
      return Right(list);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }
}
