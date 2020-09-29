import 'dart:ui';

import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:task_hard/features/home_app_bar/data/datasources/home_app_local_data_source.dart';
import 'package:task_hard/features/home_app_bar/domain/entities/home_app_bar_entity.dart';
import 'package:task_hard/features/home_app_bar/domain/repositories/home_app_bar_repository.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:meta/meta.dart';

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
}
