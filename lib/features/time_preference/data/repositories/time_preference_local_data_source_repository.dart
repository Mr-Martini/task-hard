import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/features/time_preference/data/datasources/time_preference_local_data_source.dart';
import 'package:task_hard/features/time_preference/domain/entities/time_preference.dart';
import 'package:task_hard/features/time_preference/domain/repositories/time_preference_repository.dart';
import 'package:meta/meta.dart';

class TimePreferenceLocalDataSoureceRepositoryImpl
    implements TimePreferenceRepository {
  final TimePreferenceLocalDataSource dataSource;

  TimePreferenceLocalDataSoureceRepositoryImpl({@required this.dataSource});

  @override
  Either<Failure, TimePreference> getPreference() {
    try {
      final preference = dataSource.getTimePreference();
      return Right(preference);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, TimePreference> setMorning({morning}) {
    try {
      final preference = dataSource.setMorning(morning);
      return Right(preference);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, TimePreference> setNoon({noon}) {
    try {
      final preference = dataSource.setNoon(noon);
      return Right(preference);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, TimePreference> setAfternoon({afternoon}) {
    try {
      final preference = dataSource.setAfternoon(afternoon);
      return Right(preference);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, TimePreference> setNight({night}) {
    try {
      final preference = dataSource.setNight(night);
      return Right(preference);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
